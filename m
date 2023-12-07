Return-Path: <linux-api+bounces-294-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39780960D
	for <lists+linux-api@lfdr.de>; Thu,  7 Dec 2023 23:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2043D1F21377
	for <lists+linux-api@lfdr.de>; Thu,  7 Dec 2023 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB364D586;
	Thu,  7 Dec 2023 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajlap/dw"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBA358AC;
	Thu,  7 Dec 2023 22:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E2EC433C8;
	Thu,  7 Dec 2023 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701989938;
	bh=fdYFS4UIedapRqvC5EhadTwBycy5c+nIp6a9D9KoFRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ajlap/dwWcOOVf6xWLdUG5Vsge9GGLtQW+REAyRu744RSdrP4n5ULO78N2vxy2FpO
	 2UQRb1NaMqxYWufUFrnoowD7r/oY745sxRF4hvL7U7wgJFyEu6V4ot6H2SLMPN/A7s
	 RQClP11Zuo72c7tQdSXd0+5hGtIhElFMpVn4V7xYGr9/T/DSmUcSUnVOHSR1AnyVdN
	 0aOErRZIffzAFLl1Bv9qL3teozDTKGTZkSdhi8MVeyOWxRGJw5/Q87/ecbZZw0eITJ
	 Z4yqFVk3Tj3sayaYk77t+kFOq5GySnmbwvVK7VbauzX4nteC7cEjaNh/Y/7C88vHsu
	 DP0pH+tmg5rvA==
Date: Thu, 7 Dec 2023 23:58:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
 <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttp3rprd.fsf@oldenburg.str.redhat.com>

[adjusting Cc as that's really a separate topic]

On Thu, Nov 30, 2023 at 08:43:18PM +0100, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> >>> I'd like to offer a userspace API which allows safe stashing of
> >>> unreachable file descriptors on a service thread.

Fwiw, systemd has a concept called the fdstore:

https://systemd.io/FILE_DESCRIPTOR_STORE

"The file descriptor store [...] allows services to upload during
runtime additional fds to the service manager that it shall keep on its
behalf. File descriptors are passed back to the service on subsequent
activations, the same way as any socket activation fds are passed.

[...]

The primary use-case of this logic is to permit services to restart
seamlessly (for example to update them to a newer version), without
losing execution context, dropping pinned resources, terminating
established connections or even just momentarily losing connectivity. In
fact, as the file descriptors can be uploaded freely at any time during
the service runtime, this can even be used to implement services that
robustly handle abnormal termination and can recover from that without
losing pinned resources."

> 
> >> By "safe" here do you mean not accessible via pidfd_getfd()?
> 
> No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
> intra-process transfer using /proc, but I'm hoping for something nicer.

File descriptors are reachable for all processes/threads that share a
file descriptor table. Changing that means breaking core userspace
assumptions about how file descriptors work. That's not going to happen
as far as I'm concerned.

We may consider additional security_* hooks in close*() and dup*(). That
would allow you to utilize Landlock or BPF LSM to prevent file
descriptors from being closed or duplicated. pidfd_getfd() is already
blockable via security_file_receive().

In general, messing with fds in that way is really not a good idea.

If you need something that awkward, then you should go all the way and
look at io_uring which basically has a separate fd-like handle called
"fixed files".

Fixed file indexes are separate file-descriptor like handles that can
only be used from io_uring calls but not with the regular system call
interface.

IOW, you can refer to a file using an io_uring fixed index. The index to
use can be chosen by userspace and can't be used with any regular
fd-based system calls.

The io_uring fd itself can be made a fixed file itself

The only thing missing would be to turn an io_uring fixed file back into
a regular file descriptor. That could probably be done by using
receive_fd() and then installing that fd back into the caller's file
descriptor table. But that would require an io_uring patch.

