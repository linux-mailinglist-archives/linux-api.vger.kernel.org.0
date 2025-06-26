Return-Path: <linux-api+bounces-4038-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA8AEA36F
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B567A4E54
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D720D519;
	Thu, 26 Jun 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZWOSUBy"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5A20AF62;
	Thu, 26 Jun 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955020; cv=none; b=ewlVG/D7KwYJ40QFatZt6R8A1zz94P68TU1KL+spSTnxt1ipLmdOdk7NZHEIJsiW0Se8FKW8BdUzawwFSBrNTDjCMLd+dECP9TKOjtjUJZMJg5MuPnEk/Ne0iAsbkNl83frbHXrEbKRFaLcKLu6fuGJ8NYrhjXbRwAHiA11LD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955020; c=relaxed/simple;
	bh=AL/ayqffGwaOW7aWfAzxONsmdVg4IhQmQQ3LDroZ/n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0oOcIWt6oueISPvRwcNVJKlrdHCeT1t6jDaH9JyDToChkgVmxlaAYwKi5ijqiQOGun+ONNN0uJRmsiWebb23SWIVNBGEH0S1cGkgrVCDzATK9ziJeFkt7+CGOHs09M4fSrqDTOUFelI3iMz8Rfo4i6Xt+zqkwhXDly/oxubEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZWOSUBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A7BC4CEEB;
	Thu, 26 Jun 2025 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750955019;
	bh=AL/ayqffGwaOW7aWfAzxONsmdVg4IhQmQQ3LDroZ/n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZWOSUBy299in7RzwFOlzWIeKnbZ/oojfsiofevfcFNiv8PgZceL8LfAbLKWExolB
	 4qGpmC6eoEa9GK+WyhQUzj/VEDrn9faCr1NZH35UPKbJ9fiVH6Yb3uXND2v6Rn4uKV
	 3/puAXBpvkRuSTCE1ckgo7zzUpho3T8h+7eGgAxHUEM81y8AtNiG+pYHhMP7U1z24p
	 FITvVnRIskxPdAMZpaQKeFkHfmAUD8//rmS/R/SkqzoC5ChQUges+CzavJud2SNPP2
	 6+mKlEttw3EeQCiZzRHEoasfguKmbcJ+Z3IjNpqMpba44mTtzhmorycRgJL7cZRqXb
	 oHFP6YZ25FYZQ==
Date: Thu, 26 Jun 2025 12:23:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, tools@kernel.org,
	workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aF10Cu0GI092Sjr3@lappy>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy>
 <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
 <aFwb_3EE2VMEV_tf@lappy>
 <CACT4Y+b9u6_wx9BU0hH0L6ogGKN_+R5T7OsgJVFAWm8yeD0E7Q@mail.gmail.com>
 <CACT4Y+b1Sou9bzhsuJ_LAjwCtynWN1iNRnaUkkTecNWxLUfMUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACT4Y+b1Sou9bzhsuJ_LAjwCtynWN1iNRnaUkkTecNWxLUfMUw@mail.gmail.com>

On Thu, Jun 26, 2025 at 10:37:33AM +0200, Dmitry Vyukov wrote:
>On Thu, 26 Jun 2025 at 10:32, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Wed, 25 Jun 2025 at 17:55, Sasha Levin <sashal@kernel.org> wrote:
>> >
>> > On Wed, Jun 25, 2025 at 10:52:46AM +0200, Dmitry Vyukov wrote:
>> > >On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
>> > >
>> > >> >6. What's the goal of validation of the input arguments?
>> > >> >Kernel code must do this validation anyway, right.
>> > >> >Any non-trivial validation is hard, e.g. even for open the validation function
>> > >> >for file name would need to have access to flags and check file precense for
>> > >> >some flags combinations. That may add significant amount of non-trivial code
>> > >> >that duplicates main syscall logic, and that logic may also have bugs and
>> > >> >memory leaks.
>> > >>
>> > >> Mostly to catch divergence from the spec: think of a scenario where
>> > >> someone added a new param/flag/etc but forgot to update the spec - this
>> > >> will help catch it.
>> > >
>> > >How exactly is this supposed to work?
>> > >Even if we run with a unit test suite, a test suite may include some
>> > >incorrect inputs to check for error conditions. The framework will
>> > >report violations on these incorrect inputs. These are not bugs in the
>> > >API specifications, nor in the test suite (read false positives).
>> >
>> > Right now it would be something along the lines of the test checking for
>> > an expected failure message in dmesg, something along the lines of:
>> >
>> >         https://github.com/linux-test-project/ltp/blob/0c99c7915f029d32de893b15b0a213ff3de210af/testcases/commands/sysctl/sysctl02.sh#L67
>> >
>> > I'm not opposed to coming up with a better story...
>
>If the goal of validation is just indirectly validating correctness of
>the specification itself, then I would look for other ways of
>validating correctness of the spec.
>Either removing duplication between specification and actual code
>(i.e. generating it from SYSCALL_DEFINE, or the other way around) ,
>then spec is correct by construction. Or, cross-validating it with
>info automatically extracted from the source (using
>clang/dwarf/pahole).
>This would be more scalable (O(1) work, rather than thousands more
>manually written tests).
>
>> Oh, you mean special tests for this framework (rather than existing tests).
>> I don't think this is going to work in practice. Besides writing all
>> these specifications, we will also need to write dozens of tests per
>> each specification (e.g. for each fd arg one needs at least 3 tests:
>> -1, valid fd, inclid fd; an enum may need 5 various inputs of
>> something; let alone netlink specifications).

I didn't mean just for the framework: being able to specify the APIs in
machine readable format will enable us to automatically generate
exhaustive tests for each such API.

I've been playing with the kapi tool (see last patch) which already
supports different formatters. Right now it outputs human readable
output, but I have proof-of-concept code that outputs testcases for
specced APIs.

The dream here is to be able to automatically generate
hundreds/thousands of tests for each API in an automated fashion, and
verify the results with:

1. Simply checking expected return value.

2. Checking that the actual action happened (i.e. we called close(fd),
verify that `fd` is really closed).

3. Check for side effects (i.e. close(fd) isn't supposed to allocate
memory - verify that it didn't allocate memory).

4. Code coverage: our tests are supposed to cover 100% of the code in
that APIs call chain, do we have code that didn't run (missing/incorrect
specs).

-- 
Thanks,
Sasha

