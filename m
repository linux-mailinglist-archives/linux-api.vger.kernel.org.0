Return-Path: <linux-api+bounces-3984-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE4AE7045
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 22:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E92417C4E1
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7C2D3237;
	Tue, 24 Jun 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQVak04n"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619222550D3;
	Tue, 24 Jun 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750795477; cv=none; b=imOw7k47KFLOjZ8NNH3Ta+m4Xhu1sIfmfNvAO074LJcwRTEx8Kbey395naV3/CThlGGMR0EHEZvxfoN5JhVH1cyC31IDjD88q2foyk0RrG+3Ea/Ukllxy5FhG5rBKHKmyGOS0JJXiFZampo5aK9A2S5u+AQ/gmiWsMCihLIeEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750795477; c=relaxed/simple;
	bh=tEkUdq1odJrlYhz8HYpjE+yPq4W/M576DWxjgEaSfHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeAC7kUN3BznUuNQvOtzcTg1XCIazkez/uVTxAYROFuB8f8S4P0fgJc/e0/DGuZKOVUW3+qvSZ4RaLWfbRYgfLC3r5VZeZYTT+1OXCMf8yYfkzAYaXCn0pF4ambTmWJChcYxcP/KWJcH8n715fmyUi9exOHjBWbQtaRcpJA2WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQVak04n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159F3C4CEE3;
	Tue, 24 Jun 2025 20:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750795477;
	bh=tEkUdq1odJrlYhz8HYpjE+yPq4W/M576DWxjgEaSfHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQVak04n6bC1dU+kq2uaBhkZJh596RELXHzX4GiuU1H8h0GAz9d0cdV13ZVX5Kcf4
	 xG89w31/FDXSfSf8vPAa+GFITgvkVOtLHHQuOqLlA858ZkdWrfqYHjxVqpgIlAJdo5
	 34dHXZrwpDjMDE7Kb90GjxcusCvvF1vO0esbkTfNCsNVJ2E4nXWQRhLky1JToz86kj
	 A8swqRlQ4fr8qbsSXfzyHe/PzAk5gYhl+0mfK+6hQ9wFP5wbb5gRuV0vTFLPAleun+
	 49Kfeq5WI+cTLM7dKHB9Df97viSqgqCYHd0CQCGzukaJR18zqlQSsury0QLBUCGhno
	 20bZbvode9lyw==
Date: Tue, 24 Jun 2025 16:04:34 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, tools@kernel.org,
	workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aFsE0ogdbKupvt7o@lappy>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250623132803.26760-1-dvyukov@google.com>

On Mon, Jun 23, 2025 at 03:28:03PM +0200, Dmitry Vyukov wrote:
>Nice!
>
>A bag of assorted comments:
>
>1. I share the same concern of duplicating info.
>If there are lots of duplication it may lead to failure of the whole effort
>since folks won't update these and/or they will get out of sync.
>If a syscall arg is e.g. umode_t, we already know that it's an integer
>of that enum type, and that it's an input arg.
>In syzkaller we have a Clang-tool:
>https://github.com/google/syzkaller/blob/master/tools/syz-declextract/clangtool/declextract.cpp
>that extracts a bunch of interfaces automatically:
>https://raw.githubusercontent.com/google/syzkaller/refs/heads/master/sys/linux/auto.txt
>Though, oviously that won't have user-readable string descriptions, can't be used as a source
>of truth, and may be challenging to integrate into kernel build process.
>Though, extracting some of that info automatically may be nice.
>
>2. Does this framework ensure that the specified info about args is correct?
>E.g. number of syscall args, and their types match the actual ones?
>If such things are not tested/validated during build, I afraid they will be
>riddled with bugs over time.

This is an answer for both (1) and (2): yes! In my mind, whatever we
spec out needs to be enforced, because otherwise it will go out of sync.

In this RFC, take a look at the code guarded by
CONFIG_KAPI_RUNTIME_CHECKS: the idea is that we can enable runtime
checks that verify the things you've mentioned above (and more).

>3. To reduce duplication we could use more type information, e.g. I was always
>frustrated that close is just:
>
>SYSCALL_DEFINE1(close, unsigned int, fd)
>
>whereas if we would do:
>
>typedef int fd_t;
>SYSCALL_DEFINE1(close, fd_t, fd)
>
>then all semantic info about the arg is already in the code.

Yup. It would also be great if we completely drop the SYSCALL_DEFINE()
part and have it be automatically generated by the spec itself, but I
couldn't wrap my head around doing this in C macro just yet.

>4. If we specify e.g. error return values here with descirptions,
>can that be used as the source of truth to generate man pages?
>That would eliminate some duplication.

Ideally yes. One of the formatters that the kapi tool has (see the last
patch in this series) is the RST formatter that could be used to
generate documentation similar to man pages.

>5. We have a long standing dream that kernel developers add fuzzing descirpions
>along with new kernel interfaces. So far we got very few contributions to syzkaller
>from kernel developers. This framework can serve as the way to do it, which is nice.

This was one of the main usecases I had in mind.

In return, we can get back from syzkaller a body of automatically
generated tests that we can embed into our testing CIs.

>6. What's the goal of validation of the input arguments?
>Kernel code must do this validation anyway, right.
>Any non-trivial validation is hard, e.g. even for open the validation function
>for file name would need to have access to flags and check file precense for
>some flags combinations. That may add significant amount of non-trivial code
>that duplicates main syscall logic, and that logic may also have bugs and
>memory leaks.

Mostly to catch divergence from the spec: think of a scenario where
someone added a new param/flag/etc but forgot to update the spec - this
will help catch it.

Ideally it would also prevent some of the issues that syzkaller is so
good at finding :)

>7. One of the most useful uses of this framework that I see if testing kernel
>behavior correctness. I wonder what properties we can test with these descirptions,
>and if we can add more useful info for that purpose.
>Argument validation does not help here (it's userspace bugs at best).
>Return values potentially may be useful, e.g. if we see a return value that's
>not specified, potentially it's a kernel bug.
>Side-effects specification potentially can be used to detect logical kernel bugs,
>e.g. if a syscall does not claim to change fs state, but it does, it's a bug.
>Though, a more useful check should be failure/concurrency atomicity.
>Namely, if a syscall claims to not alter state on failure, it shouldn't do so.
>Concurrency atomicity means linearizability of concurrent syscalls
>(side-effects match one of 2 possible orders of syscalls).
>But for these we would need to add additional flags to the descriptions
>that say that a syscall supports failure/concurrency atomicity.

I agree: being able to fuzz for more than just kernel splats will be
great.

>8. It would be useful to have a mapping of file_operations to actual files in fs.
>Otherwise the exposed info is not very actionable, since there is no way to understand
>what actual file/fd the ioctl's can be applied to.

Ack. The ioctl() part is a bit hand weavy right now, and at the very
least we'd need to spec out ioctl() itself. It's more of a demonstration
of how it could look like rather than being too useful at this point.

>9. I see that syscalls and ioctls say:
>KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
>Can't we make this implicit? Are there any other options?

Maybe? I wasn't sure how we'd describe somthing like getpid() which
isn't supposed to sleep.

>Similarly an ioctl description says it releases a mutex (.released = true,),
>all ioctls/syscalls must release all acquired mutexes, no?
>Generally, the less verbose the descriptions are, the higher chances of their survival.
>+Marco also works static compiler-enforced lock checking annotations,
>I wonder if they can be used to describe this in a more useful way.

I was thinking about stuff like futex or flock which can return with a
lock back to userspace.

-- 
Thanks,
Sasha

