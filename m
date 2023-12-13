Return-Path: <linux-api+bounces-333-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EFA8110E3
	for <lists+linux-api@lfdr.de>; Wed, 13 Dec 2023 13:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EB7281A84
	for <lists+linux-api@lfdr.de>; Wed, 13 Dec 2023 12:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87F28E01;
	Wed, 13 Dec 2023 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnwXJIqH"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E128DC7;
	Wed, 13 Dec 2023 12:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81F1C433C8;
	Wed, 13 Dec 2023 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702469888;
	bh=fOi26p1uWxnqpvwuqGwXpnv62gezURvfN1QJ75LNswM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnwXJIqH4fCdac/GM8uGsKkXH5rlvQ7LiX5pZhrfsZ8C/JpJFSxcUzvISxvfa8DM0
	 BfWjylNwolszu4Qg2m29OKpVydAqtd5GsS3xLX4hzcut94iNBqN4jYw1Nzy+5HZOcZ
	 Kog93MndP4PC3NGIEi+9KxXdcb4Yy2YNljHEDo1Fh//JacBp7Ly75ihx9XFd5G1r2x
	 3FmqpFdEuGwNA/1f6avfR1Gm1huDFzU879oG7fFwqNZ95bpa9mXXO6F03q+jskimhw
	 Gs9JNfL6is5fN4Ry3TGnxa0NvgxUyI2FuqYZzUhFryz2gdwwnSk/NuTFCmQBGfCqsv
	 4xZFpk69q2WcQ==
Date: Wed, 13 Dec 2023 13:18:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20231213-famos-chillen-41adc67ac0ef@brauner>
References: <20231207170946.130823-1-tycho@tycho.pizza>
 <202312111516.26dc3fd5-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312111516.26dc3fd5-oliver.sang@intel.com>

On Mon, Dec 11, 2023 at 03:28:09PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.pidfd.pidfd_test.fail" on:
> 
> commit: e6d9be676d2c1fa8332c63c4382b8d3227fca991 ("[PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group leaders")
> url: https://github.com/intel-lab-lkp/linux/commits/Tycho-Andersen/selftests-pidfd-add-non-thread-group-leader-tests/20231208-011135
> patch link: https://lore.kernel.org/all/20231207170946.130823-1-tycho@tycho.pizza/
> patch subject: [PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-60acb023-1_20230329
> with following parameters:
> 
> 	group: pidfd
> 
> 
> 
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202312111516.26dc3fd5-oliver.sang@intel.com
> 
> 
> besides, we also observed kernel-selftests.pidfd.pidfd_poll_test.fail on this
> commit, but clean on parent:
> 
> bee0e7762ad2c602 e6d9be676d2c1fa8332c63c4382
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     kernel-selftests.pidfd.pidfd_poll_test.fail
>            :6          100%           6:6     kernel-selftests.pidfd.pidfd_test.fail
> 
> 
> 
> TAP version 13
> 1..7
> # timeout set to 300
> # selftests: pidfd: pidfd_test
> # TAP version 13
> # 1..8
> # # Parent: pid: 2191
> # # Parent: Waiting for Child (2192) to complete.
> # # Child (pidfd): starting. pid 2192 tid 2192
> # # Child Thread: starting. pid 2192 tid 2193 ; and sleeping
> # # Child Thread: doing exec of sleep
> # Bail out! pidfd_poll check for premature notification on child thread exec test: Unexpected epoll_wait result (c=0, events=0) (errno 0)

So it seems that this broke multi-threaded exit notifications.

