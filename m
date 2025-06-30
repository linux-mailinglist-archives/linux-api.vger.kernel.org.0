Return-Path: <linux-api+bounces-4060-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733CAEE0B1
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0763AF043
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397428C851;
	Mon, 30 Jun 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq7I9ZSy"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898528C5CE;
	Mon, 30 Jun 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293651; cv=none; b=ILHfKizQrc4OGISZ8NM6juw48og8ZMhkjTnsGNA7bYMF1F1hSDpz3nCQiVF+7o1XqgO6xbI/e+s3+62pdkzrmn6aR4fjVsZhi8NqHjCvVwqgIajM2pPNCjcuEZm16xU2bX9auttwQAAIGCOwGhCeN3UvgkbFps4TR7ybKWWd5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293651; c=relaxed/simple;
	bh=LuPF47WhT0AJn95Uf0PtKKadOSwppv1z8iDklhuyFAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+55LO2pBrOBF2OX60XEu+uI//SGA3bIdvYujvv+OLynFG+E3G/Nwu5LOCmUGMtbdWF1beAaj5c8zvR3ue43Pco69HVn7x7jxvwBTSUc4nuOnzpDPVxJkYFwKrsgZGd3xLZGqJQVitsWBUmYsitFR88tu5Yfvnbqv0C3p7sUDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq7I9ZSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E76C4CEE3;
	Mon, 30 Jun 2025 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751293650;
	bh=LuPF47WhT0AJn95Uf0PtKKadOSwppv1z8iDklhuyFAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fq7I9ZSyMC+55NSAgzCN3tL69hpCl4CwhmC3n0tv56trL2dGP/WsHr3pQd/eMPTjP
	 mwGosZhofwYUcC8yQsEXlpIVigwGwF9btxbySx5AXDea0Z2n2CBdjS7G0RUA5XLt8O
	 ficf0iHlU7yoYS1iuOjIlhyEenc7LwyE2XPJrmIAHrEGsNZiP5U8bcUW4QvUKBXxWP
	 5GYJc0qw63wdQRbIbMvcx1SoXVHK2VT/LUaARMYt5r9eLeficss+9DyiRPBb+XWbon
	 04fy1717BVMq7lkyJ8myidWHmnDHC0b/geDP99HfmUCAG6FICwHQdNjBrkp7ZSQX0Z
	 PCru1U+uhJWWA==
Date: Mon, 30 Jun 2025 10:27:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, tools@kernel.org,
	workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aGKe0bcv1mzBnnQr@lappy>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy>
 <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
 <aFwb_3EE2VMEV_tf@lappy>
 <CACT4Y+b9u6_wx9BU0hH0L6ogGKN_+R5T7OsgJVFAWm8yeD0E7Q@mail.gmail.com>
 <CACT4Y+b1Sou9bzhsuJ_LAjwCtynWN1iNRnaUkkTecNWxLUfMUw@mail.gmail.com>
 <aF10Cu0GI092Sjr3@lappy>
 <CACT4Y+ZB45ovD0hX3xX_yTUVSRDc1UCXnVDB57jxyWPPc7k=MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZB45ovD0hX3xX_yTUVSRDc1UCXnVDB57jxyWPPc7k=MA@mail.gmail.com>

On Fri, Jun 27, 2025 at 08:23:41AM +0200, Dmitry Vyukov wrote:
>On Thu, 26 Jun 2025 at 18:23, Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Thu, Jun 26, 2025 at 10:37:33AM +0200, Dmitry Vyukov wrote:
>> >On Thu, 26 Jun 2025 at 10:32, Dmitry Vyukov <dvyukov@google.com> wrote:
>> >>
>> >> On Wed, 25 Jun 2025 at 17:55, Sasha Levin <sashal@kernel.org> wrote:
>> >> >
>> >> > On Wed, Jun 25, 2025 at 10:52:46AM +0200, Dmitry Vyukov wrote:
>> >> > >On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
>> >> > >
>> >> > >> >6. What's the goal of validation of the input arguments?
>> >> > >> >Kernel code must do this validation anyway, right.
>> >> > >> >Any non-trivial validation is hard, e.g. even for open the validation function
>> >> > >> >for file name would need to have access to flags and check file precense for
>> >> > >> >some flags combinations. That may add significant amount of non-trivial code
>> >> > >> >that duplicates main syscall logic, and that logic may also have bugs and
>> >> > >> >memory leaks.
>> >> > >>
>> >> > >> Mostly to catch divergence from the spec: think of a scenario where
>> >> > >> someone added a new param/flag/etc but forgot to update the spec - this
>> >> > >> will help catch it.
>> >> > >
>> >> > >How exactly is this supposed to work?
>> >> > >Even if we run with a unit test suite, a test suite may include some
>> >> > >incorrect inputs to check for error conditions. The framework will
>> >> > >report violations on these incorrect inputs. These are not bugs in the
>> >> > >API specifications, nor in the test suite (read false positives).
>> >> >
>> >> > Right now it would be something along the lines of the test checking for
>> >> > an expected failure message in dmesg, something along the lines of:
>> >> >
>> >> >         https://github.com/linux-test-project/ltp/blob/0c99c7915f029d32de893b15b0a213ff3de210af/testcases/commands/sysctl/sysctl02.sh#L67
>> >> >
>> >> > I'm not opposed to coming up with a better story...
>> >
>> >If the goal of validation is just indirectly validating correctness of
>> >the specification itself, then I would look for other ways of
>> >validating correctness of the spec.
>> >Either removing duplication between specification and actual code
>> >(i.e. generating it from SYSCALL_DEFINE, or the other way around) ,
>> >then spec is correct by construction. Or, cross-validating it with
>> >info automatically extracted from the source (using
>> >clang/dwarf/pahole).
>> >This would be more scalable (O(1) work, rather than thousands more
>> >manually written tests).
>> >
>> >> Oh, you mean special tests for this framework (rather than existing tests).
>> >> I don't think this is going to work in practice. Besides writing all
>> >> these specifications, we will also need to write dozens of tests per
>> >> each specification (e.g. for each fd arg one needs at least 3 tests:
>> >> -1, valid fd, inclid fd; an enum may need 5 various inputs of
>> >> something; let alone netlink specifications).
>>
>> I didn't mean just for the framework: being able to specify the APIs in
>> machine readable format will enable us to automatically generate
>> exhaustive tests for each such API.
>>
>> I've been playing with the kapi tool (see last patch) which already
>> supports different formatters. Right now it outputs human readable
>> output, but I have proof-of-concept code that outputs testcases for
>> specced APIs.
>>
>> The dream here is to be able to automatically generate
>> hundreds/thousands of tests for each API in an automated fashion, and
>> verify the results with:
>>
>> 1. Simply checking expected return value.
>>
>> 2. Checking that the actual action happened (i.e. we called close(fd),
>> verify that `fd` is really closed).
>>
>> 3. Check for side effects (i.e. close(fd) isn't supposed to allocate
>> memory - verify that it didn't allocate memory).
>>
>> 4. Code coverage: our tests are supposed to cover 100% of the code in
>> that APIs call chain, do we have code that didn't run (missing/incorrect
>> specs).
>
>
>This is all good. I was asking the argument verification part of the
>framework. Is it required for any of this? How?

Specifications without enforcement are just documentation :)

In my mind, there are a few reasons we want this:

1. For folks coding against the kernel, it's a way for them to know that
the code they're writing fits within the spec of the kernel's API.

2. Enforcement around kernel changes: think of a scenario where a flag
is added to a syscall - the author of that change will have to also
update the spec because otherwise the verification layer will complain
about the new flag. This helps prevent divergence between the code and
the spec.

3. Extra layer of security: we can choose to enable this as an
additional layer to protect us from missing checks in our userspace
facing API.

-- 
Thanks,
Sasha

