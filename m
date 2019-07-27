Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE7277B05
	for <lists+linux-api@lfdr.de>; Sat, 27 Jul 2019 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfG0SYz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Jul 2019 14:24:55 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:32826 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387945AbfG0SYy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 27 Jul 2019 14:24:54 -0400
Received: from [37.170.35.169] (helo=opteyam2)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hrRMh-000A9w-T9; Sat, 27 Jul 2019 20:24:20 +0200
Message-ID: <542deab5d3450adc004602b9b8bbb4e38824c35b.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     christian@brauner.io, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, dancol@google.com,
        tglx@linutronix.de, jannh@google.com, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Date:   Sat, 27 Jul 2019 20:24:13 +0200
In-Reply-To: <20190726162226.252750-2-surenb@google.com>
References: <20190726162226.252750-1-surenb@google.com>
         <20190726162226.252750-2-surenb@google.com>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.170.35.169
X-SA-Exim-Mail-From: ydroneaud@opteya.com
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ou.quest-ce.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham version=3.3.2
Subject: Re: [PATCH v3 2/2] tests: add pidfd poll tests
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Le vendredi 26 juillet 2019 à 09:22 -0700, Suren Baghdasaryan a écrit :
> This adds testing for polling on pidfd of a process being killed. Test runs
> 10000 iterations by default to stress test pidfd polling functionality.
> It accepts an optional command-line parameter to override the number or
> iterations to run.
> Specifically, it tests for:
> - pidfd_open on a child process succeeds
> - pidfd_send_signal on a child process succeeds
> - polling on pidfd succeeds and returns exactly one event
> - returned event is POLLIN
> - event is received within 3 secs of the process being killed
> 
> 10000 iterations was chosen because of the race condition being tested
> which is not consistently reproducible but usually is revealed after less
> than 2000 iterations.
> Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  tools/testing/selftests/pidfd/.gitignore      |   1 +
>  tools/testing/selftests/pidfd/Makefile        |   2 +-
>  .../testing/selftests/pidfd/pidfd_poll_test.c | 117 ++++++++++++++++++
>  3 files changed, 119 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c
> 
> diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
> index 16d84d117bc0..a67896347d34 100644
> --- a/tools/testing/selftests/pidfd/.gitignore
> +++ b/tools/testing/selftests/pidfd/.gitignore
> @@ -1,2 +1,3 @@
>  pidfd_open_test
> +pidfd_poll_test
>  pidfd_test
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index 720b2d884b3c..ed58b7108d18 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -g -I../../../../usr/include/ -lpthread
>  
> -TEST_GEN_PROGS := pidfd_test pidfd_open_test
> +TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test
>  
>  include ../lib.mk
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> new file mode 100644
> index 000000000000..f1b62b91e53e
> --- /dev/null
> +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <poll.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syscall.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "pidfd.h"
> +#include "../kselftest.h"
> +
> +static bool timeout;
> +
> +static void handle_alarm(int sig)
> +{
> +	timeout = true;
> +}

Not needed if poll() timeout is used instead.

> +
> +int main(int argc, char **argv)
> +{
> +	struct pollfd fds;
> +	int iter, nevents;
> +	int nr_iterations = 10000;
> +
> +	fds.events = POLLIN;
> +
> +	if (argc > 2)
> +		ksft_exit_fail_msg("Unexpected command line argument\n");
> +
> +	if (argc == 2) {
> +		nr_iterations = atoi(argv[1]);
> +		if (nr_iterations <= 0)
> +			ksft_exit_fail_msg("invalid input parameter %s\n",
> +					argv[1]);
> +	}
> +
> +	ksft_print_msg("running pidfd poll test for %d iterations\n",
> +		nr_iterations);
> +
> +	for (iter = 0; iter < nr_iterations; iter++) {
> +		int pidfd;
> +		int child_pid = fork();
> +
> +		if (child_pid < 0) {
> +			if (errno == EAGAIN) {
> +				iter--;
> +				continue;
> +			}
> +			ksft_exit_fail_msg(
> +				"%s - failed to fork a child process\n",
> +				strerror(errno));
> +		}
> +
> +		if (child_pid == 0) {
> +			/* Child process just sleeps for a min and exits */
> +			sleep(60);

Instead of relying on a timer for no reason, I would use the following:

	while (1)
		pause();

> +			exit(EXIT_SUCCESS);
> +		}
> +
> +		/* Parent kills the child and waits for its death */
> +		pidfd = sys_pidfd_open(child_pid, 0);
> +		if (pidfd < 0)
> +			ksft_exit_fail_msg("%s - pidfd_open failed\n",
> +					strerror(errno));
> +
> +		/* Setup 3 sec alarm - plenty of time */
> +		if (signal(SIGALRM, handle_alarm) == SIG_ERR)
> +			ksft_exit_fail_msg("%s - signal failed\n",
> +					strerror(errno));
> +		alarm(3);
> +

Would the poll() timeout be more simpler to use than relying on
SIGALRM: no need to setup signal, no need for handler, no need for
timeout variable.

> +		/* Send SIGKILL to the child */
> +		if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0))
> +			ksft_exit_fail_msg("%s - pidfd_send_signal failed\n",
> +					strerror(errno));
> +
> +		/* Wait for the death notification */
> +		fds.fd = pidfd;
> +		nevents = poll(&fds, 1, -1);
> +

With

        nevents = poll(&fds, 1, 3000);

> +		/* Check for error conditions */
> +		if (nevents < 0)
> +			ksft_exit_fail_msg("%s - poll failed\n",
> +					strerror(errno));
> +

And
	if (nevents == 0)
		ksft_exit_fail_msg(
			"death notification wait timeout\n");
 
> +		if (nevents != 1)
> +			ksft_exit_fail_msg("unexpected poll result: %d\n",
> +					nevents);
> +
> +		if (!(fds.revents & POLLIN))
> +			ksft_exit_fail_msg(
> +				"unexpected event type received: 0x%x\n",
> +				fds.revents);
> +
> +		if (timeout)
> +			ksft_exit_fail_msg(
> +				"death notification wait timeout\n");
> +
> +		close(pidfd);
> +		// Wait for child to prevent zombies
> +		if (waitpid(child_pid, NULL, 0) < 0)
> +			ksft_exit_fail_msg("%s - waitpid failed\n",
> +					strerror(errno));

I feel safer now you defeated the zombies army :) Thanks.

> +
> +	}
> +
> +	ksft_test_result_pass("pidfd poll test: pass\n");
> +	return ksft_exit_pass();
> +}

Regards

-- 
Yann Droneaud
OPTEYA


