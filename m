Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8DE45ED
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405057AbfJYIlq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Oct 2019 04:41:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38624 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404179AbfJYIlq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Oct 2019 04:41:46 -0400
Received: from [185.240.52.243] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iNvAF-0001cC-V2; Fri, 25 Oct 2019 08:41:44 +0000
Date:   Fri, 25 Oct 2019 10:41:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: clone3() example code
Message-ID: <20191025084142.jpwypkyczehylhgv@wittgenstein>
References: <CAKgNAkgKX1Z6Uns3pAvXe-JMSmWqo2PrqeoS65aEriZsV35QmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgNAkgKX1Z6Uns3pAvXe-JMSmWqo2PrqeoS65aEriZsV35QmA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On Fri, Oct 25, 2019 at 10:13:23AM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Christian,

Hey Michael,

> 
> Do you have some example user-space code somewhere that illustrates
> calling clone3(). I'm looking at how we might document that system
> call in the manual page, and some example code to play with would be

Excellent!

> useful at this point. (I already have a simple working test program,
> but probably you have something better.)

Not sure about something better but one simple thing I used (a more
extensive test-suite is coming):

#define _GNU_SOURCE
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/sysmacros.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <unistd.h>

#ifndef CLONE_PIDFD
#define CLONE_PIDFD 0x00001000
#endif

#ifndef __NR_clone3
#define __NR_clone3 -1
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
	struct clone_args args = {0};

	args.parent_tid = ptr_to_u64(&parent_tid); /* CLONE_PARENT_SETTID */
	args.pidfd = ptr_to_u64(&pidfd); /* CLONE_PIDFD */
	args.flags = CLONE_PIDFD | CLONE_PARENT_SETTID;
	args.exit_signal = SIGCHLD;

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
	printf("Parent process received child's pidfd %d\n", *(int *)args.pidfd);
	printf("Parent process received child's pid %d as return argument\n",
	       *(pid_t *)args.parent_tid);

	if (0) {
		if (waitid(P_ALL, pid, NULL, 0) == 0) {
			fprintf(stderr, "Managed to wait on CLONE_NO_WAITALL process with waitid(P_ALL)\n");
			exit(EXIT_FAILURE);
		}
		printf("Child process %d requested CLONE_NO_WAITALL\n", pid);
	} else {
		printf("Child process %d did not request CLONE_NO_WAITALL\n", pid);
	}

	if (wait_for_pid(pid))
		exit(EXIT_FAILURE);

	if (pid != *(pid_t *)args.parent_tid)
		exit(EXIT_FAILURE);

	close(pidfd);

	return 0;
}

Thanks!
Christian
