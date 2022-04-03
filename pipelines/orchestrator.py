from users_pipeline import users_pipeline
from posts_pipeline import posts_pipeline
from comments_pipeline import comments_pipeline

def main():
    users_pipeline()
    posts_pipeline()
    comments_pipeline()

if __name__ == '__main__':
    main()