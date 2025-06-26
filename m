Return-Path: <linux-api+bounces-4034-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A9AE985D
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 10:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116C95A1405
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DA29008E;
	Thu, 26 Jun 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJLM/NFG"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C00269806
	for <linux-api@vger.kernel.org>; Thu, 26 Jun 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926780; cv=none; b=ew+q7dIT1JKWr0URkUmMk1GQlEqgY+9YB5igBdlzoeOi/vGS9lanzqtm7RVWvXUojku5XL2KbaAI0WDSPR3htmMyVEyS1e91MOm6dQe5XpqVTJKhfYWqmP2RZA+3Dyb9xneXm8D/TSU+DC4LDNtTcfPZ50xrwxq6FcyMqrEJ6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926780; c=relaxed/simple;
	bh=/EXnmyDqhgwhNubqEJ+Z7XqtbTMhvh+9M0BZvcE+S0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS6AkOidRr21fE4389Uxgcwm/ci7QPliqBqajeyrhHJRAwNcbH8JEMU3N1FkpP+VxHmD9lJQVSx+NVUuE1hbw1IXSITkwmQHDjahhWf1wE9jTo31T5H7K7fz8OQhW/M/iKXL194hN6ub+aou0ayxyxf5De1nhulgbQAo7ELE9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJLM/NFG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso6509421fa.1
        for <linux-api@vger.kernel.org>; Thu, 26 Jun 2025 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750926776; x=1751531576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZyqW6LTgx3qQCdMf7DVmwLH6L5ZjexEcMKkRJNzkQg=;
        b=FJLM/NFGEiPONX4FrdSZ0hI/cQk82eO+Lo5YVkchHl8WweUn2tSD6hRktRnJ8QG3vo
         vTJolU3CiS6Cy/pbdjy14FvlPP2Kli+M+DptWSEI/w0U4sem0vUwh1eUvq5kGAYIYvzX
         O8JseJRSOyvj4mqXPvxoSv31hO8QB7HK0gWaImazyNXVnceVZd4E1fYedMkLj1srp10I
         0pej8WZrfLXOJ2fMKlViXyXGNXbe8Lf9ViRgjzppBCSI14J/f+hJxdgsrInoUvTnYufR
         kFVgkbqHWPIgD7tBdjSK0WMLLhnE7YBhuGjSKfnqUnRCf/DC/GT/tGNf9yo/pdRwoy3h
         vqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926776; x=1751531576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZyqW6LTgx3qQCdMf7DVmwLH6L5ZjexEcMKkRJNzkQg=;
        b=de2rFxlt9SLFh1t296JohBCCjmph6zErf9bhthEphvBgtlbZimJiyiV1Rz2gvAQqPw
         gRWBrZhsnn/ji77zUBGqdCG3Jj2/r0KPj5MnEoXDK2aGCw3vqK/j0bXSTafskrGOJncc
         rggQ8ypwiuT0aXtFivKuWVop+geax+mXGbaJoUFmqkMcJ60L1VqoM11YL5bYdBZp5UNP
         k8t3nxvWwkmz7RRFCYK2ylHG12LxVT4s8tpQsugr5auyRP+jnocEgIqNKDC51D3cNy7r
         wBkRKSiCm5Gm6PpaWqvGnArOYeFzCQrQ1Sx2zCZEdMFAsaumFhjbCA9BZ6jeOzLOWWwg
         Ze+A==
X-Forwarded-Encrypted: i=1; AJvYcCWKLAWftBiLNB0tmvjWD23y7ltHoVOktkQeWBlES3QRsZWQ+EWhvhyEXBOi0Y2nKZTS8SadECuHJic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTN1Y3x9rPUY0C2O7puFwhEJkpWsvuApnfkKdOaPtoHXj10PSJ
	tvKQKH1djsniLCoWcR/U3mHBRnu3hxLNSUdOdsDCzPd3bd6Ab2j24ADCOMPLVHRRrZz8+W8yc9j
	LMXW/RIsrxCQKFH3JLpRl5wvj1N0TX+KK5Fc8i7rw
X-Gm-Gg: ASbGncuq5h5MVLIw/rkaC3TuRcmzlVw/IeYj4YXCDCS9QOHkjIb4SLYf/IBQ9EtHJoo
	loj22fGkRgYab3Yh9ueUkKb+qBKd48W4q4YiRm77fenseuJa37IPWErFjSUnXFr2+EMZM5+EYBW
	W6Yfjf3zh/7XeuYgo7RZ7fFg4f1FnGxU/VJ9/IY3fdsiFwBSy3SgT6G1pQrzxN0F+3z/oCChO23
	lIx
X-Google-Smtp-Source: AGHT+IETo+L/oV+R/tmnVYW2Qg4rA4aBv5GWRJ/qPp97+u4UznXO8eCK5nvO+CRrEHedFW1CDFl6j9Mm6w/bd2AvpQI=
X-Received: by 2002:a2e:9059:0:b0:32b:5eb3:280 with SMTP id
 38308e7fff4ca-32ccfa91d8emr7830071fa.29.1750926776245; Thu, 26 Jun 2025
 01:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFNYQkbEctT6N0Hb@lappy> <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy> <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
 <aFwb_3EE2VMEV_tf@lappy>
In-Reply-To: <aFwb_3EE2VMEV_tf@lappy>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 26 Jun 2025 10:32:45 +0200
X-Gm-Features: Ac12FXwPRCYLCXOzZA2k06HmxFcMR3fWIsqQHlWuGEU7Sh27__v25jmGtwOdH6Q
Message-ID: <CACT4Y+b9u6_wx9BU0hH0L6ogGKN_+R5T7OsgJVFAWm8yeD0E7Q@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 17:55, Sasha Levin <sashal@kernel.org> wrote:
>
> On Wed, Jun 25, 2025 at 10:52:46AM +0200, Dmitry Vyukov wrote:
> >On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
> >
> >> >6. What's the goal of validation of the input arguments?
> >> >Kernel code must do this validation anyway, right.
> >> >Any non-trivial validation is hard, e.g. even for open the validation function
> >> >for file name would need to have access to flags and check file precense for
> >> >some flags combinations. That may add significant amount of non-trivial code
> >> >that duplicates main syscall logic, and that logic may also have bugs and
> >> >memory leaks.
> >>
> >> Mostly to catch divergence from the spec: think of a scenario where
> >> someone added a new param/flag/etc but forgot to update the spec - this
> >> will help catch it.
> >
> >How exactly is this supposed to work?
> >Even if we run with a unit test suite, a test suite may include some
> >incorrect inputs to check for error conditions. The framework will
> >report violations on these incorrect inputs. These are not bugs in the
> >API specifications, nor in the test suite (read false positives).
>
> Right now it would be something along the lines of the test checking for
> an expected failure message in dmesg, something along the lines of:
>
>         https://github.com/linux-test-project/ltp/blob/0c99c7915f029d32de893b15b0a213ff3de210af/testcases/commands/sysctl/sysctl02.sh#L67
>
> I'm not opposed to coming up with a better story...

Oh, you mean special tests for this framework (rather than existing tests).
I don't think this is going to work in practice. Besides writing all
these specifications, we will also need to write dozens of tests per
each specification (e.g. for each fd arg one needs at least 3 tests:
-1, valid fd, inclid fd; an enum may need 5 various inputs of
something; let alone netlink specifications).

