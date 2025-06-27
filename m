Return-Path: <linux-api+bounces-4051-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C858DAEAEFE
	for <lists+linux-api@lfdr.de>; Fri, 27 Jun 2025 08:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A935169F81
	for <lists+linux-api@lfdr.de>; Fri, 27 Jun 2025 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230220CCCA;
	Fri, 27 Jun 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmOl2NqA"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34713207A0C
	for <linux-api@vger.kernel.org>; Fri, 27 Jun 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005437; cv=none; b=bFpa+jt4HsrkvCs9PA+C0aBfrPMAM2Qrus2Oo9hmurhIKtgjDWbR3nEuetA8YlxzT2tk6miIRNp88WQXbFXp6Odjtv2VfprKgiahn0DkPoYS7o2NU/b/+paQ5nJE5Oces8JwprreWdCl5jjFs6qKQoic8BXaE11U7Hig/G58big=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005437; c=relaxed/simple;
	bh=JnvY3RTmBx6MRqAVlV09eZbQ7sUKQlL0Z57F3QhInhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4w699qhSdMAwhLKjs57chj33zyIBTzQv8A5BIKCbnpz47iHHol2OtGrUeGIibnnI6G5t/5l/Ue3aU6UBj3XiXU9x9J6sY6cuLRW3hhgvi/UmlIhIyukAs05YSTv5lrclkxmmFGHb83Upj2lNB3MeX2yq9IBkPP5fGNznLGMwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmOl2NqA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so13527001fa.0
        for <linux-api@vger.kernel.org>; Thu, 26 Jun 2025 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751005433; x=1751610233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRG6NNG0VVS1jQpfAYOrqcRu7QV8DTB5ZsV0Je+hvWM=;
        b=lmOl2NqAi6qQWiT66POpwtJzpdKBFT4hqF+fBTY2YYgfBBmzGO8e4umVZSjFwk/6t8
         jZKV7QjuAK7pJ2FSZDAlXR83jwdIxVQ+yDHU+dS14vVwsM7HuNfPFzS5G1NzZNVDRhvQ
         Bj5uN6sBlRoEnLTsWqjX+5Iqu8B575NTUB9NAxX7b1/T7SyIvQBfG7Z2h2M09+DgdqFq
         2IeM9vE9So8+6RX1pngN2WL+5g9A91yvg6hm7Tncny8fiH7d928hqyQzyoj80oPU+LZI
         B/zWD5/I7QkcfUQo49MvOWNHPd9weNG7qMROCYaBqDmTA8ykaeER10MaqqjNQRlQRWZf
         4D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751005433; x=1751610233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRG6NNG0VVS1jQpfAYOrqcRu7QV8DTB5ZsV0Je+hvWM=;
        b=KoLwggw6BCN9UITY/lPhcQeKblpL0i6TTHHUqpsHBwWdnIghUN3F5sXEFKrNK6qtTj
         iBQ4dAAnw6+wmFUIKETHgYJSb9ELORftKJwKU8n9obyaVHz0n0/dMpaEe1KUHKStlG5Y
         Q3B2M13JZ4RPDPYpYz86G4vsvGu/8BjR3cBHGqZPRIoUCZu+644iJNnb/kLgTF5rMAeL
         6tI/3RB9WWtYLkk2tsFTsBtnwS9Hf+hBEa0ThmnSJe0kr6AoVXSNfed5CjrrDp6SCWH+
         taQ95ZLNfhNtrb2eUqsLl8/Yn6OCcizbqam+wLTgVP0IgLxoe33STgaPjQOnseUmzcxi
         eXXw==
X-Forwarded-Encrypted: i=1; AJvYcCXAMAHn/gsP/WZiyIO7QPeCa0HrZEGsVISsK4LRyyO4YYCqsNbc0ojogY1E2pKJddSI26+f8+qnw74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+n5donrO3Wbl5TXFjry+zjtqchOy8lXiYVVm5LRfqpnMwh1+7
	95W6qEkIbw919upSPRmiysG32NNIA4fzMOk2bHLdhCMPErXpuE3OV2dy9YI2J7jNx9zDa7/rfGB
	jJPCKnuzqdiklw1ncbLBPH/GIL+Ewz6LG8O36YlcpqUM6xw1xGeNELev3
X-Gm-Gg: ASbGncs6R3Wb9V5W1YYrBrZ4VcLcp8Z+dWpeAs1rxnTrNDJqQckcXMV3D8hSfaEMtbB
	lQFa3xsJqHu1MFOHoW1gRSMTL9T3Uz/P2AEjTvEdoiBiUD/XmyOKZDyCDeXVaIfBIDUaQn7FK7Z
	550JCUIgZmo8JKO0pR3tMvbx0+IpBsjy+BO7vMjulCEWFPYQt34JNsruysZsOiwCUx3r2fS2Khi
	BcQ
X-Google-Smtp-Source: AGHT+IGK26L0oF+ODv4+XuY/ZlAuNolDiZF/FXqYhLEt198LoohKc+0K2UtZS/2z5j494oWFlLA35IH14x7tPXsm0Fk=
X-Received: by 2002:a05:651c:20c2:b0:32c:a006:2a36 with SMTP id
 38308e7fff4ca-32cdc524859mr3524071fa.20.1751005432932; Thu, 26 Jun 2025
 23:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFNYQkbEctT6N0Hb@lappy> <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy> <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
 <aFwb_3EE2VMEV_tf@lappy> <CACT4Y+b9u6_wx9BU0hH0L6ogGKN_+R5T7OsgJVFAWm8yeD0E7Q@mail.gmail.com>
 <CACT4Y+b1Sou9bzhsuJ_LAjwCtynWN1iNRnaUkkTecNWxLUfMUw@mail.gmail.com> <aF10Cu0GI092Sjr3@lappy>
In-Reply-To: <aF10Cu0GI092Sjr3@lappy>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Jun 2025 08:23:41 +0200
X-Gm-Features: Ac12FXyAYSKfz7cidEHmKYezvS3_pE2Q0zztohcM72AP4oIRG48UsLnRi3saK5Y
Message-ID: <CACT4Y+ZB45ovD0hX3xX_yTUVSRDc1UCXnVDB57jxyWPPc7k=MA@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 18:23, Sasha Levin <sashal@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 10:37:33AM +0200, Dmitry Vyukov wrote:
> >On Thu, 26 Jun 2025 at 10:32, Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> On Wed, 25 Jun 2025 at 17:55, Sasha Levin <sashal@kernel.org> wrote:
> >> >
> >> > On Wed, Jun 25, 2025 at 10:52:46AM +0200, Dmitry Vyukov wrote:
> >> > >On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
> >> > >
> >> > >> >6. What's the goal of validation of the input arguments?
> >> > >> >Kernel code must do this validation anyway, right.
> >> > >> >Any non-trivial validation is hard, e.g. even for open the validation function
> >> > >> >for file name would need to have access to flags and check file precense for
> >> > >> >some flags combinations. That may add significant amount of non-trivial code
> >> > >> >that duplicates main syscall logic, and that logic may also have bugs and
> >> > >> >memory leaks.
> >> > >>
> >> > >> Mostly to catch divergence from the spec: think of a scenario where
> >> > >> someone added a new param/flag/etc but forgot to update the spec - this
> >> > >> will help catch it.
> >> > >
> >> > >How exactly is this supposed to work?
> >> > >Even if we run with a unit test suite, a test suite may include some
> >> > >incorrect inputs to check for error conditions. The framework will
> >> > >report violations on these incorrect inputs. These are not bugs in the
> >> > >API specifications, nor in the test suite (read false positives).
> >> >
> >> > Right now it would be something along the lines of the test checking for
> >> > an expected failure message in dmesg, something along the lines of:
> >> >
> >> >         https://github.com/linux-test-project/ltp/blob/0c99c7915f029d32de893b15b0a213ff3de210af/testcases/commands/sysctl/sysctl02.sh#L67
> >> >
> >> > I'm not opposed to coming up with a better story...
> >
> >If the goal of validation is just indirectly validating correctness of
> >the specification itself, then I would look for other ways of
> >validating correctness of the spec.
> >Either removing duplication between specification and actual code
> >(i.e. generating it from SYSCALL_DEFINE, or the other way around) ,
> >then spec is correct by construction. Or, cross-validating it with
> >info automatically extracted from the source (using
> >clang/dwarf/pahole).
> >This would be more scalable (O(1) work, rather than thousands more
> >manually written tests).
> >
> >> Oh, you mean special tests for this framework (rather than existing tests).
> >> I don't think this is going to work in practice. Besides writing all
> >> these specifications, we will also need to write dozens of tests per
> >> each specification (e.g. for each fd arg one needs at least 3 tests:
> >> -1, valid fd, inclid fd; an enum may need 5 various inputs of
> >> something; let alone netlink specifications).
>
> I didn't mean just for the framework: being able to specify the APIs in
> machine readable format will enable us to automatically generate
> exhaustive tests for each such API.
>
> I've been playing with the kapi tool (see last patch) which already
> supports different formatters. Right now it outputs human readable
> output, but I have proof-of-concept code that outputs testcases for
> specced APIs.
>
> The dream here is to be able to automatically generate
> hundreds/thousands of tests for each API in an automated fashion, and
> verify the results with:
>
> 1. Simply checking expected return value.
>
> 2. Checking that the actual action happened (i.e. we called close(fd),
> verify that `fd` is really closed).
>
> 3. Check for side effects (i.e. close(fd) isn't supposed to allocate
> memory - verify that it didn't allocate memory).
>
> 4. Code coverage: our tests are supposed to cover 100% of the code in
> that APIs call chain, do we have code that didn't run (missing/incorrect
> specs).


This is all good. I was asking the argument verification part of the
framework. Is it required for any of this? How?

