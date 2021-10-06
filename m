Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163434243A7
	for <lists+linux-api@lfdr.de>; Wed,  6 Oct 2021 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJFRGC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Oct 2021 13:06:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53144 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJFRGA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Oct 2021 13:06:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:36740)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mYAKs-002YNJ-SG; Wed, 06 Oct 2021 11:04:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55904 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mYAKr-003tPS-Jp; Wed, 06 Oct 2021 11:04:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
References: <87v92qx2c6.fsf@disp2133> <87y27mvnke.fsf@disp2133>
        <202109241154.A915C488E2@keescook>
Date:   Wed, 06 Oct 2021 12:03:59 -0500
In-Reply-To: <202109241154.A915C488E2@keescook> (Kees Cook's message of "Fri,
        24 Sep 2021 11:56:00 -0700")
Message-ID: <87r1cynkzk.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-XM-SPF: eid=1mYAKr-003tPS-Jp;;;mid=<87r1cynkzk.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/73Tt77EGtRCccwo1zaoQiPNBwHgvdS4Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 619 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.93 (0.3%),
         extract_message_metadata: 20 (3.2%), get_uri_detail_list: 3.1 (0.5%),
        tests_pri_-1000: 28 (4.5%), tests_pri_-950: 1.49 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 159 (25.7%), check_bayes:
        156 (25.2%), b_tokenize: 10 (1.7%), b_tok_get_all: 12 (1.9%),
        b_comp_prob: 6 (1.0%), b_tok_touch_all: 121 (19.6%), b_finish: 1.13
        (0.2%), tests_pri_0: 378 (61.1%), check_dkim_signature: 0.88 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 12 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/6] coredump: Limit coredumps to a single thread group
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--=-=-=
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Thu, Sep 23, 2021 at 07:12:33PM -0500, Eric W. Biederman wrote:
>> 
>> Today when a signal is delivered with a handler of SIG_DFL whose
>> default behavior is to generate a core dump not only that process but
>> every process that shares the mm is killed.
>> 
>> In the case of vfork this looks like a real world problem.  Consider
>> the following well defined sequence.
>> 
>> 	if (vfork() == 0) {
>> 		execve(...);
>> 		_exit(EXIT_FAILURE);
>> 	}
>> 
>> If a signal that generates a core dump is received after vfork but
>> before the execve changes the mm the process that called vfork will
>> also be killed (as the mm is shared).
>> 
>> Similarly if the execve fails after the point of no return the kernel
>> delivers SIGSEGV which will kill both the exec'ing process and because
>> the mm is shared the process that called vfork as well.
>> 
>> As far as I can tell this behavior is a violation of people's
>> reasonable expectations, POSIX, and is unnecessarily fragile when the
>> system is low on memory.
>> 
>> Solve this by making a userspace visible change to only kill a single
>> process/thread group.  This is possible because Jann Horn recently
>> modified[1] the coredump code so that the mm can safely be modified
>> while the coredump is happening.  With LinuxThreads long gone I don't
>> expect anyone to have a notice this behavior change in practice.
>> 
>> To accomplish this move the core_state pointer from mm_struct to
>> signal_struct, which allows different thread groups to coredump
>> simultatenously.
>> 
>> In zap_threads remove the work to kill anything except for the current
>> thread group.
>> 
>> [1] a07279c9a8cd ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
>> Fixes: d89f3847def4 ("[PATCH] thread-aware coredumps, 2.5.43-C3")
>> History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> This looks correct to me, but depends on the 5/6 not introducing any
> races. So, to that end:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> If you have some local tools you've been using for testing this series,
> can you toss them into tools/testing/selftests/ptrace/ ? I can help
> clean them up if want.

I just have a program that goes multi-thread and calls abort, and a
slight variant of it that calls vfork before calling abort.

It is enough to exercise the code and verify I didn't make any typos.

I have attached the code below.  If you can help make it into a proper
test that would be great.  I have just been manually running gdb
and the like to verify the kernel works as expected.

Eric


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=threaded-coredump.c

#include <stdio.h>
#include <pthread.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

struct params {
	int argc;
	char **argv;
	char **envp;
	pthread_t parent;
	pthread_t sibling[30];
};

static void *dump_thread(void *arg)
{
	struct params *params = arg;
	void *retval;
	int i;

	pthread_join(params->parent, &retval);
	fprintf(stdout, "Waiting for 5s\n");
	sleep(5);
	fprintf(stdout, "Dumping\n");
	abort();
	fprintf(stdout, "Abort Failed: %d %s\n", errno, strerror(errno));
	for (i = 0; i <= 29; i++) {
		pthread_join(params->sibling[i], &retval);
	}
	fprintf(stdout, "All Done!\n");
	_exit(EXIT_FAILURE);
	return NULL;
}

static void *idle_thread(void *arg)
{
	unsigned long i = (unsigned long)arg;
	sleep(10);
	fprintf(stdout, "Done %lu\n", i);
	fflush(stdout);
	return NULL;
}

int main(int argc, char **argv, char **envp)
{
	struct params *params;
	pthread_t pt;
	unsigned long i;

	params = malloc(sizeof(struct params));
	params->argc = argc - 1;
	params->argv = argv = argv + 1;
	params->envp = envp;
	params->parent = pthread_self();

	pthread_create(&pt, NULL, dump_thread, params);
	for (i = 0; i <= 29; i++)
		pthread_create(&params->sibling[i], NULL, idle_thread, (void *)i);
	pthread_exit(NULL);

	return 0;
}

--=-=-=--
