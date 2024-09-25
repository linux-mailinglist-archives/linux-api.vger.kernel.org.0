Return-Path: <linux-api+bounces-2338-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B43986628
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D046284B38
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA784A31;
	Wed, 25 Sep 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMR9tZAi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FC487B0;
	Wed, 25 Sep 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288098; cv=none; b=ooleYRiL7V3WIMr1gzhrKqrcOKY8zfDPXX7gQf+mij5y7TnskKu9WTDqG9/DA4fvQXTv2490wvc0BVydqh3dk+VW4TlcE2aBzANvCiTMBUAMUidClar/bFVu/bj4PRwmTD338Cz4lETJmb7FjM1n3qdbcKUcvyD/ZUP/HTmDjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288098; c=relaxed/simple;
	bh=Brs38/1S0S76Kg1t7svAxBmaNEjhuOhU7czMnTKTrSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smYH7QvDX21k+7HcFU08E9MCd7BvDmMGzRp0U4VRvxwNyoxHS3GzzB699q1IQoTBidhaF+qZP9bSSDnRjH8CVNYTGyJu62vdgmL6zw8bEPjBf6Q1EwwUU1CSHGHLDcRsU22o/lEs6g3cTUj/AghRSCQsy/iYSrAIKXIQoIRHTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMR9tZAi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso752895e9.1;
        Wed, 25 Sep 2024 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727288095; x=1727892895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs/OaRoXH7r4WJREprSEKPkU6ufEx25AKBj03vNjsoo=;
        b=VMR9tZAig8eb1ENcpEzMUM9JrCTKhTnmzuZXWqcF+mBucDZqLmH297i63B9NOlCPqu
         0C/ap4RJ0VmDdvp3vS+Pt+Uk7iOFR0GyMgIfSUyTVmseHhNKWPbJsISm0onSm2mkWjhc
         7cVHh1BaWSajWffynlU0hRc6zkfUwB3+lDl/E4tHJxS8yLeqc6U7N7dyZ/yBxKHWlmhv
         qjr52cZWjb396GD5UTjDfBDsiSNJ4S2XIVu3eSio/vUEBB/s2ubyYmBR2sZLJ5kC22v3
         EbRj4nAnGg8ismgVo7IH4yB/dDcGPW/x2uUvZRT+6qBWY2lLfXnf41Wn6chHF+dLQDgN
         MJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288095; x=1727892895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs/OaRoXH7r4WJREprSEKPkU6ufEx25AKBj03vNjsoo=;
        b=rq0gUvUn5CsX6cZ+0ujbN+TL2HugWWiYk+VqkUgp/TQWDan6MNMxIgMvrtkhVsYfFE
         wiPa2eZBvqlsoicMi5EkCYJ9Aa3KYMO1ihubnogEzk0C0xR5H7X6rnJxs+LrAbx9rVRL
         3S+sDzXD+37RTNLsSiMg/p+oSjnI3MWuiSKPfY2SAGj/7gs6nybm122PJ978N0OuIn92
         vzZKIt4lozboaodyJ0fn3bcXa2VEO4oLI8L5VNQcuHKy1U+H/4lpJeudDTIMvCitu/ye
         B2cFNhPXGTboLh8FJ99Ghv1S9mqxMWuutOtqLQwThUIGJ4mOc0np4xkyowHIwOv7W0pc
         y1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUmtRWBBmBeTu6LrRBuEsji7tQL3bMRwcIglV1w6IW7ABKGoTi5emiT+tCfgp/WkljjfjfN927XYhKe@vger.kernel.org, AJvYcCUoVR6geXjIWJZL0ave+1lqVxlQwulsAwuT5EsO9JC7D63+x7cBgY3zxDOr1mtOnQzOMj2CJYSZbsr5j7w9@vger.kernel.org, AJvYcCVz8CBW7EdbZKgxT1BpHmHBmkrT4DY5vcZVWM0gExA7PsIcxwTBYwJWF9JCX4mAbEYz1KqkwY+opFEuCFRB@vger.kernel.org, AJvYcCW+VikI5Cq60VSe11OTfrRoRpGrm8G7NZFwYNDEIEuDt/UTcfWNXWXcJQxOCpTuJkWijxgJ2HxD4AvZEQ==@vger.kernel.org, AJvYcCXdLyeH1dmatIaPFqgikCOgbPCBiNR50g0PWOHQTxEi9LxrhX0GExqxT15cQ+n0d8EaJ+Rldj7vl2/YqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb49g0MSx/etVt+wb8sTecf3bl9g2dfPwL7T7urcAu4kpIAt3I
	oa2reiyYbLaumia6gEy20dXS/BpcY5q8CjDqWOS06xnOu/kemiAJ
X-Google-Smtp-Source: AGHT+IGw172XRvIlpNhc591coaXRGWw/ar0SMJ/7qKN79L95cpb2J1AIEZ4lhoV7s3kLF9nP8R8OAA==
X-Received: by 2002:a05:600c:4928:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42e9624523fmr24491225e9.30.1727288094608;
        Wed, 25 Sep 2024 11:14:54 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2cf144sm4569012f8f.57.2024.09.25.11.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:14:54 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:14:51 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, christian@brauner.io
Subject: Re: [PATCH v2 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <asbdij3q2iabrnq5wdxmcq3g7ofut2malicushswi3rma6glf5@k6eftopwmwvj>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
 <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
 <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
 <xilfrvlstq4fqr46jlrzvq2vlr22nizdrwlcdizp774nlt6pfj@jukzlcwc7bed>
 <7f40a8f6-c2f1-45f2-b9ff-88e169a33906@lucifer.local>
 <wvk5y3m47qmox4by6u3zpxtwartjmoaqaaqswbgui626zkjajq@22wjmqo36hes>
 <6b449c32-0954-4db1-9df5-23b766dc2d9a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b449c32-0954-4db1-9df5-23b766dc2d9a@lucifer.local>

On Wed, Sep 25, 2024 at 06:04:59PM GMT, Lorenzo Stoakes wrote:
> On Wed, Sep 25, 2024 at 09:19:17AM GMT, Shakeel Butt wrote:
> > I have no idea what makes you think I am blocking the feature that you
> > repond in a weird tone but let me be upfront what I am asking: Let's
> > collectively decide which is the better option (in terms of
> > maintainability and extensibility) and move forward.
> 
> I'm not sure what you mean by 'weird tone'... perhaps a miscommunication?
> 
> To summarise in my view - a suggestion was made to, rather than provide the
> proposed flag - a pidfd sentinel should be introduced.
> 
> Simply introducing a sentinel that represents 'the current process' without
> changing interfaces that accept a pidfd would be broken - so implementing
> this implies that _all_ pidfd interfaces are updated, as well as tests.
>

While I suggested PIDFD_SELF, I never meant that we should change every interface,
but rather adopt a sound, consistent strategy for pidfd interfaces and stick with
it for the foreseeable future.

In this case, we'd adapt process_madvise, then possibly later pidfd_send_signal, etc.
There are plenty of pidfd interfaces that don't make sense with a PIDFD_SELF. Various
other interfaces will probably never want to adopt it at all (select _can't_, other
fs syscalls such as read/write/poll/whatever would require awful handholding from
various kernel subsystems, while in that sense we would definitely require a proper
struct file/inode/whatever for each pseudo-fd, which is not exactly what we want).

> I suggest doing so is, of course, entirely out of the scope of this
> change. Therefore if we were to require that here - it would block the
> feature while I go work on that.
> 
> I think this is pretty clear right? And I also suggest that doing so is
> likely to take quite some time, and may not even have a positive outcome.
> 
> So it's not a case of 'shall we take approach A or approach B?' but rather
> 'should we take approach A or entirely implement a new feature B, then once
> that is done, use it'.
> 
> So as to your 'collectively decide what is the better option' - in my
> previous response I argued that the best approach between 'use an
> unimplemented suggested entirely new feature of pidfd' vs. 'implement a
> flag that would in no way block the prior approach' - a flag works better.

I just don't think it's a new feature, just an established, future-proof way
of doing things :) Your patch should remain mostly similar apart from switching
the flag check into an fd check.

> >
> > By big undertaking, do you mean other syscalls that take pidfd
> > (pidfd_getfd, pidfd_send_signal & process_mrelease) to handle PIDFD_SELF
> > or something else?
> 
> I mean if you add a pidfd sentinel that represents 'the current process' it
> may get passed to any interface that accepts a pidfd, so all of them have
> to handle it _somehow_.
> 
> Also you'll want to update tests accordingly and clearly need to get
> community buy-in for that feature.
> 
> You may want to just add a bunch of:
> 
> if (pidfd == SENTINEL)
> 	return -EINVAL;

It should already be there in the form of an -EBADF.

> 
> So it's not impossible my instincts are off and we can get away with simply
> doing that.
> 
> On the other hand, would that be confusing? Wouldn't we need to update
> documentation, manpages, etc. to say explicitly 'hey this sentinel is just
> not supported'?

This is a fair point, but we could also just... not :) which I don't feel is too
wrong, since the fd works kind of like a flag here.

-- 
Pedro

