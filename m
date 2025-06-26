Return-Path: <linux-api+bounces-4035-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C17AE989A
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 10:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1117AFA42
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F391C2957A9;
	Thu, 26 Jun 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKIuUEzV"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118825E448
	for <linux-api@vger.kernel.org>; Thu, 26 Jun 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927068; cv=none; b=kL5Re7Vm/1NMjWbvsrpdoQrh1HaB7cmIImMGYK3JLhk5VvtejddXvQkW4jq68elc3qjHaUSdjB0SqwbctbUmosGLz7FgFV9okwceVIVPbSka1588E3y12aGMKtE5/axQG3vHsPzloG91IFEg3EMYG8SvrTpAWIVbd03DnlBKOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927068; c=relaxed/simple;
	bh=61NR3+cv2s+s8non1oheMAZjlDoX1CX3MknyPY6bDPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ply6+H/T4avedmmaWPM1S7h9iPnRmQDpzzdoOrSyHtyvUwdOs3/kV84BNyv/WXmts9RiOH7N3tbIgdTDJUwo26KIjxFhxT+uGCHhvfAa+W2HKp+k8TB3umzwuLb0HnjvyHbj1DBNkM/+9AAwKXMjkdP83K6nnPEUJ7OXm9ykcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKIuUEzV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so8061421fa.1
        for <linux-api@vger.kernel.org>; Thu, 26 Jun 2025 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750927065; x=1751531865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LOVSm2lxlfvHzHWNA6nGxFDSpaI7yd4pLz8A6iME9uA=;
        b=MKIuUEzVQIcmMdKU3umjnTlK7MaISvXiPxmI9b8x7G4ODEkVKgQay1l9COTq/9+bNO
         FB1XgAscObG5wp+hdLIMG2TWL2oiKbF7w59KJwHq5xxvLLKZz0jn/ftrtA+eIpVr0sRg
         GGX6Lvv5AEQV7FbpMQrMe6pi1CMcfnQicEl8EEvaubcg2hdSnlA1fZmE0tx/zXwv+Rgw
         4CWZfgq4gTEq/yYsjpF4wxn+047j+px8s0A3E207294ZYQMw8kQILB+qulyEKLHIbqir
         nCvloDgir3Hkt/VzosMMSbU5qOBtU7Z7kElhKTL5HDRJzTJFCWfR6nhgu7OFwMrh1E/T
         GZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927065; x=1751531865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOVSm2lxlfvHzHWNA6nGxFDSpaI7yd4pLz8A6iME9uA=;
        b=a7JBrPNRzVTrBzSsbptM1EUOHWOTQc56ghqoqjWi3FM2s5UZ02nOTm2M4MuiTVOgsl
         Pled7dyJH/Mgtlbj2AG9sKXvz+qsupBErOin4v0FL5pnSu1T8mbikh/AYN9Z7myjTOaN
         v9SLIE6F55cuEQv9A5nAQipF5CHAq/YiHxvpQzcD1ohS0Z1qcm36+dibUNsGTyFNFBb8
         tTnY3DNIfJ1Z8tyY6OTcLpBkHX86FkMkOlcwkhkftVrEz64mw3/gof9xc5c+kUI5zKFV
         riXNP7NatyajPIBXKuCWaL/SUGiy/6bkf7gg+gm1xJRz3bFlKCrHjeGnYXqEW4bhqe9A
         1dDw==
X-Forwarded-Encrypted: i=1; AJvYcCUDlsbjmLbjRnUQmSKeMMRiEjV4GEMzxH5P6qsdXkHUQJU6Q1RyGNx92ygbg/6eKIiDrPMeZi6MdVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKZZeEzxE46KUMeoSSDp0iozml0lPXYP6KqWqAo9hWaZ51qDz
	2huvBGGaYDZglyLmyrYmqKaB0Jv5CZYNSuZI/TBWS6X6rx/qythX9s7nEDNLqMYapEumlH7pvX/
	/ntf3SfejuLDLK+H7iLvTG1vPlE9acqrIv2ZmGzd2
X-Gm-Gg: ASbGncuW5Zv0fuVitLca6C9aXcY/vHAM8cyHI8EeFu5jyTwT/DcSi5WqqPECeDOwjjy
	PzAto7PtsydUEJM2f112F9vM/4FgziOny1V+Rw7/9uZAkFeKT0dUinkXTPvmioQMz3QVPCs2j0z
	muEMqyCmhdIlJnrlS1klBWVN6jK1QneMEHbcqaYzIi2h6MYbQbN0xsuj+/G4yiOG50xzOyXKK9N
	MokHwp4OBCwxiA=
X-Google-Smtp-Source: AGHT+IFoce4glEmRfpaGq1cEJXdDdpQIuRzef09xN/mVCcmD+KVlQpUFkduHrAryLe+sJhQ5P60PGjtSCXUKZH3ivEQ=
X-Received: by 2002:a05:651c:4088:b0:32b:871e:9862 with SMTP id
 38308e7fff4ca-32cd0261797mr6223281fa.20.1750927064914; Thu, 26 Jun 2025
 01:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFNYQkbEctT6N0Hb@lappy> <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy> <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
 <aFwb_3EE2VMEV_tf@lappy> <CACT4Y+b9u6_wx9BU0hH0L6ogGKN_+R5T7OsgJVFAWm8yeD0E7Q@mail.gmail.com>
In-Reply-To: <CACT4Y+b9u6_wx9BU0hH0L6ogGKN_+R5T7OsgJVFAWm8yeD0E7Q@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 26 Jun 2025 10:37:33 +0200
X-Gm-Features: Ac12FXzg-OSj1zle3ASePCxnUdh4OCWuOBwquUmVr7PDJNx1ZtzdOjfrL6XnuBI
Message-ID: <CACT4Y+b1Sou9bzhsuJ_LAjwCtynWN1iNRnaUkkTecNWxLUfMUw@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 10:32, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 25 Jun 2025 at 17:55, Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Wed, Jun 25, 2025 at 10:52:46AM +0200, Dmitry Vyukov wrote:
> > >On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > >> >6. What's the goal of validation of the input arguments?
> > >> >Kernel code must do this validation anyway, right.
> > >> >Any non-trivial validation is hard, e.g. even for open the validation function
> > >> >for file name would need to have access to flags and check file precense for
> > >> >some flags combinations. That may add significant amount of non-trivial code
> > >> >that duplicates main syscall logic, and that logic may also have bugs and
> > >> >memory leaks.
> > >>
> > >> Mostly to catch divergence from the spec: think of a scenario where
> > >> someone added a new param/flag/etc but forgot to update the spec - this
> > >> will help catch it.
> > >
> > >How exactly is this supposed to work?
> > >Even if we run with a unit test suite, a test suite may include some
> > >incorrect inputs to check for error conditions. The framework will
> > >report violations on these incorrect inputs. These are not bugs in the
> > >API specifications, nor in the test suite (read false positives).
> >
> > Right now it would be something along the lines of the test checking for
> > an expected failure message in dmesg, something along the lines of:
> >
> >         https://github.com/linux-test-project/ltp/blob/0c99c7915f029d32de893b15b0a213ff3de210af/testcases/commands/sysctl/sysctl02.sh#L67
> >
> > I'm not opposed to coming up with a better story...

If the goal of validation is just indirectly validating correctness of
the specification itself, then I would look for other ways of
validating correctness of the spec.
Either removing duplication between specification and actual code
(i.e. generating it from SYSCALL_DEFINE, or the other way around) ,
then spec is correct by construction. Or, cross-validating it with
info automatically extracted from the source (using
clang/dwarf/pahole).
This would be more scalable (O(1) work, rather than thousands more
manually written tests).

> Oh, you mean special tests for this framework (rather than existing tests).
> I don't think this is going to work in practice. Besides writing all
> these specifications, we will also need to write dozens of tests per
> each specification (e.g. for each fd arg one needs at least 3 tests:
> -1, valid fd, inclid fd; an enum may need 5 various inputs of
> something; let alone netlink specifications).

