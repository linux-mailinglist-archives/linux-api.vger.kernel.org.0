Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D938912C38B
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfL2ROy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 12:14:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfL2ROy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 12:14:54 -0500
Received: from [172.58.107.62] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ilc9T-000399-Bm; Sun, 29 Dec 2019 17:14:52 +0000
Date:   Sun, 29 Dec 2019 18:14:43 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <20191229171441.fxif7q32mv2hl3y4@wittgenstein>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229062451.9467-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191229062451.9467-3-sargun@sargun.me>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 10:24:51PM -0800, Sargun Dhillon wrote:
> Add a self-test to make sure that the kernel returns EINVAL, if any
> of the fields in seccomp_notif are set to non-null.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index f53f14971bff..379391a7fa41 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -3601,6 +3601,29 @@ TEST(user_notification_continue)
>  	}
>  }
>  
> +TEST(user_notification_garbage)
> +{
> +	/*
> +	 * intentionally set pid to a garbage value to make sure the kernel
> +	 * catches it
> +	 */
> +	struct seccomp_notif req = {
> +		.pid	= 1,
> +	};
> +	int ret, listener;
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
> +	ASSERT_GE(listener, 0);
> +
> +	EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
> +	EXPECT_EQ(EINVAL, errno);

Does that even work if no dup() syscall has been made and trapped?
This looks like it would give you ENOENT...

If you want a simple solution just do:

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6944b898bb53..4c73ae8679ea 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3095,7 +3095,7 @@ TEST(user_notification_basic)
        pid_t pid;
        long ret;
        int status, listener;
-       struct seccomp_notif req = {};
+       struct seccomp_notif req;
        struct seccomp_notif_resp resp = {};
        struct pollfd pollfd;

@@ -3158,6 +3158,13 @@ TEST(user_notification_basic)
        EXPECT_GT(poll(&pollfd, 1, -1), 0);
        EXPECT_EQ(pollfd.revents, POLLIN);

+       /* Test that we can't pass garbage to the kernel. */
+       memset(&req, 0, sizeof(req));
+       req.pid = -1;
+       EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
+       EXPECT_EQ(EINVAL, errno);
+
+       req.pid = 0;
        EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);

        pollfd.fd = listener


If you want a complete separate test then you can do:

TEST(user_notification_garbage_recv)
{
	pid_t pid;
	long ret;
	int status, listener;
	struct seccomp_notif req;
	struct seccomp_notif_resp resp = {};
	struct pollfd pollfd;

	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
	ASSERT_EQ(0, ret) {
		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
	}

	listener = user_trap_syscall(__NR_getppid,
				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
	ASSERT_GE(listener, 0);

	pid = fork();
	ASSERT_GE(pid, 0);

	if (pid == 0) {
		ret = syscall(__NR_getppid);
		exit(ret != USER_NOTIF_MAGIC);
	}

	pollfd.fd = listener;
	pollfd.events = POLLIN | POLLOUT;

	EXPECT_GT(poll(&pollfd, 1, -1), 0);
	EXPECT_EQ(pollfd.revents, POLLIN);

	memset(&req, 0, sizeof(req));
	req.pid = -1;
   	EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
   	EXPECT_EQ(EINVAL, errno);

	req.pid = 0;
	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);

	pollfd.fd = listener;
	pollfd.events = POLLIN | POLLOUT;

	EXPECT_GT(poll(&pollfd, 1, -1), 0);
	EXPECT_EQ(pollfd.revents, POLLOUT);

	EXPECT_EQ(req.data.nr,  __NR_getppid);

	memset(&resp, 0, sizeof(resp));
	resp.id = req.id;
	resp.error = 0;
	resp.val = USER_NOTIF_MAGIC;
	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);

	EXPECT_EQ(waitpid(pid, &status, 0), pid);
	EXPECT_EQ(true, WIFEXITED(status));
	EXPECT_EQ(0, WEXITSTATUS(status));
}

Christian
