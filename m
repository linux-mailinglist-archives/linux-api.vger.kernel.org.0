Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E275BE47EE
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408956AbfJYJ4y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Oct 2019 05:56:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40638 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408934AbfJYJ4y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Oct 2019 05:56:54 -0400
Received: from [185.240.52.243] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iNwKw-00077y-MR; Fri, 25 Oct 2019 09:56:50 +0000
Date:   Fri, 25 Oct 2019 11:56:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: clone3() example code
Message-ID: <20191025095647.ga74uchqhflpliec@wittgenstein>
References: <CAKgNAkgKX1Z6Uns3pAvXe-JMSmWqo2PrqeoS65aEriZsV35QmA@mail.gmail.com>
 <20191025084142.jpwypkyczehylhgv@wittgenstein>
 <20191025094956.hvr44v2lbfxf7dfs@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025094956.hvr44v2lbfxf7dfs@yavin.dot.cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 25, 2019 at 08:49:56PM +1100, Aleksa Sarai wrote:
> On 2019-10-25, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
> > 
> > int main(int argc, char *argv[])
> > {
> > 	int pidfd = -1;
> > 	pid_t parent_tid = -1, pid = -1;
> > 	struct clone_args args = {0};
> > 
> > 	args.parent_tid = ptr_to_u64(&parent_tid); /* CLONE_PARENT_SETTID */
> > 	args.pidfd = ptr_to_u64(&pidfd); /* CLONE_PIDFD */
> > 	args.flags = CLONE_PIDFD | CLONE_PARENT_SETTID;
> > 	args.exit_signal = SIGCHLD;
> > 
> > 	pid = sys_clone3(&args);
> 
> I'd suggest that
> 
> 	struct clone_args args = {
> 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
> 		.parent_tid = ptr_to_u64(&parent_tid), /* CLONE_PARENT_SETTID */
> 		.pidfd = ptr_to_u64(&pidfd),           /* CLONE_PIDFD */
> 		.exit_signal = SIGCHLD,
> 	};
> 
> or alternatively
> 
> 	pid = sys_clone3(&(struct clone_args) {
> 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
> 		.parent_tid = ptr_to_u64(&parent_tid), /* CLONE_PARENT_SETTID */
> 		.pidfd = ptr_to_u64(&pidfd),           /* CLONE_PIDFD */
> 		.exit_signal = SIGCHLD,
> 	});
> 
> are easier to read.

That was an accident. I posted from the wrong file. The correct code is:

#ifndef _GNU_SOURCE
#define _GNU_SOURCE 1
#endif
#include <errno.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#ifndef CLONE_PIDFD
#define CLONE_PIDFD 0x00001000
#endif

#ifndef __NR_clone3
#define __NR_clone3 -1
struct clone_args {
	__aligned_u64 flags;
	__aligned_u64 pidfd;
	__aligned_u64 child_tid;
	__aligned_u64 parent_tid;
	__aligned_u64 exit_signal;
	__aligned_u64 stack;
	__aligned_u64 stack_size;
	__aligned_u64 tls;
};
#endif

static pid_t sys_clone3(struct clone_args *args)
{
	return syscall(__NR_clone3, args, sizeof(struct clone_args));
}

static int wait_for_pid(pid_t pid)
{
	int status, ret;

again:
	ret = waitpid(pid, &status, 0);
	if (ret == -1) {
		if (errno == EINTR)
			goto again;

		return -1;
	}

	if (ret != pid)
		goto again;

	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
		return -1;

	return 0;
}

#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))

int main(int argc, char *argv[])
{
	int pidfd = -1;
	pid_t parent_tid = -1, pid = -1;
	struct clone_args args = {
		/* CLONE_PARENT_SETTID */
		.parent_tid = ptr_to_u64(&parent_tid),
		/* CLONE_PIDFD */
		.pidfd = ptr_to_u64(&pidfd),
		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
		.exit_signal = SIGCHLD,
	};

	pid = sys_clone3(&args);
	if (pid < 0) {
		fprintf(stderr, "%s - Failed to create new process\n", strerror(errno));
		exit(EXIT_FAILURE);
	}

	if (pid == 0) {
		printf("Child process with pid %d\n", getpid());
		exit(EXIT_SUCCESS);
	}

	printf("Parent process received child's pid %d as return value\n", pid);
	printf("Parent process received child's pidfd %d\n", pidfd);
	printf("Parent process received child's pid %d as return argument\n",
	       *(pid_t *)args.parent_tid);

	if (wait_for_pid(pid)) {
		fprintf(stderr, "Failed to wait on child process\n");
		exit(EXIT_FAILURE);
	}

	if (pid != parent_tid)
		exit(EXIT_FAILURE);

	close(pidfd);

	return 0;
}
