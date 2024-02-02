Return-Path: <linux-api+bounces-817-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802A847ACF
	for <lists+linux-api@lfdr.de>; Fri,  2 Feb 2024 21:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39851C2585B
	for <lists+linux-api@lfdr.de>; Fri,  2 Feb 2024 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DF7E111;
	Fri,  2 Feb 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NbD/Fj1f"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1F7A723
	for <linux-api@vger.kernel.org>; Fri,  2 Feb 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907351; cv=none; b=hDZp31yn0dYODjqYD69quOgvTKVEceTrwkDGyoTxtJ4bCiLz3AZbRkWJx6DbSnYjVWZ7+lXoB8k/pAodIOLYirrvk9Edcp4EiIUdbo8SWEYixR4HyK77qCE1ulo0rWzLe8cqqEgsX2rF3iRO58St3g99TdVSMnKoML9lJNcsvoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907351; c=relaxed/simple;
	bh=Q3IL2wclKku6uCJCDZOhOybhrhzcE4XFHuOMnR/baLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSdSYXCVxK2WCM6To68qol5J5GM+nzP3yJhWUSyUbRZOv1adk8gP2Vjd0dlvwKWSZGbWzjmfeQqaJVlFBxTObZ8lzQmPPGPUqY6zplztSjz/OjihzI9ngGogunSgtQ4HAEa4BYeJcIW4z1MA/SvPKAXvmpEb2HA8bfivMeMJW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NbD/Fj1f; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2963cc5e8acso898307a91.2
        for <linux-api@vger.kernel.org>; Fri, 02 Feb 2024 12:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706907349; x=1707512149; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZGxR4o9c4pYSgCi9H6AQReXwYkD08B5eCkb5+mQ4TY=;
        b=NbD/Fj1f7GI3IonlhsaCmHCwdnGHoU+YVZMr23I+JoomXx6Q3CJnoL+xFot+S2q3Zb
         I5s76H3B9DHkP86/oehlswmSXXlb/NGX0XeCVIEIoJnPHWwsoh9zitgFY8x0Ck6LYW70
         IVYwoXiz9XHxz08YM8nHLS1zIl8Kiw03BJ7KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907349; x=1707512149;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZGxR4o9c4pYSgCi9H6AQReXwYkD08B5eCkb5+mQ4TY=;
        b=u0Uat9oXBe4wsOQloGvwWAmA8Trl2WcoK0QlZWHLwizpYfox4CuHaTOCAYlcRpTd+6
         iLBbmfsVQ5PTJ0nD1zqU5cYaMMe5RCEHqWnhLfwSquAi6zm61W4+tRFoqea17XyWAjub
         Nv0UOAtSxg1acpbYfs+JY95QvcuW/vvH938rXpIjhWb0JVsAD1IAetlqCzw9oabPxtxT
         tK/1nNM042HF5wcmmyhlRvLlWJV46myM+E/bXiuVr24lv8KvNSCI6D6ubqxsw7M/XorI
         ZRKPbwOuFf4ItExLoRwnQAG4leV/hVHdHTd/2RWLuMotCqE3AfwVD5lfrujoPqQ3NrTi
         1HRQ==
X-Gm-Message-State: AOJu0YxoJXBZ7MghburojvC4h86zyc+5l15V7CUlYWBbtrxoBL6i9UQz
	tv8hYcaNBxWVQx06Hi7mRg4O5aEmiR+N6dWFK6ZmIc8WOsl1UXVN/sh7BTfphcM=
X-Google-Smtp-Source: AGHT+IEidvjI5rEOFXviWvR25Q2r1BYhnGDU4zBTZGCuO+yclQX3B9a1DH5Hy6lNDg+2U8v9PbieNA==
X-Received: by 2002:a17:90a:db0d:b0:296:321e:99ef with SMTP id g13-20020a17090adb0d00b00296321e99efmr3418060pjv.17.1706907349489;
        Fri, 02 Feb 2024 12:55:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3qwOU9zuPWXhZEyUgneDFWUTTmCrL2wpY9reLblZfXsvU50SoGEuOS26C3mAsbQ4cPnFpA8YNPx0Rv8ceFPiPRCZ2ETaMxC0DvZZgp3xogbX5lMU/3COKwr8jJRh3dujGNieNV/po135dfl3aFy00zUJqKb/fIWAaQKX72/eds7/vwTh52o6Tq8PHCrSvJgCanOQ7/wqPh+n1dcO/BgHU2F8rd7XghUzfv/vMRdNzD58W8TSwYQDGIr5geZJfT4zG+Iz6pR3Wlsn7Jegxjpz7n9GdJiTj4IM98sJ95xuWz180FshZM2g9deI4crwARk/HIsG3uLS5z/tWjdhYuYxQThBVJ41svHPqCkNw9A77c2IcUyzZhrVJ6Rs2e+9ZbHRYAlxYaaxp6pahcf+zX9b+Ql0=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id gj8-20020a17090b108800b0029604b0b7d1sm487987pjb.15.2024.02.02.12.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:55:49 -0800 (PST)
Date: Fri, 2 Feb 2024 12:55:46 -0800
From: Joe Damato <jdamato@fastly.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
	alexander.duyck@gmail.com, Wei Wang <weiwan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240202205545.GA9484@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
 <20240202032806.GA8708@fastly.com>
 <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
 <20240202102239.274ca9bb@kernel.org>
 <20240202193332.GA8932@fastly.com>
 <20240202115828.6fd125bf@kernel.org>
 <20240202202344.GA9283@fastly.com>
 <0d030b68-0371-4460-8d76-cad129888496@intel.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d030b68-0371-4460-8d76-cad129888496@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Fri, Feb 02, 2024 at 02:50:58PM -0600, Samudrala, Sridhar wrote:
> 
> 
> On 2/2/2024 2:23 PM, Joe Damato wrote:
> >On Fri, Feb 02, 2024 at 11:58:28AM -0800, Jakub Kicinski wrote:
> >>On Fri, 2 Feb 2024 11:33:33 -0800 Joe Damato wrote:
> >>>On Fri, Feb 02, 2024 at 10:22:39AM -0800, Jakub Kicinski wrote:
> >>>>On Fri, 2 Feb 2024 11:23:28 -0600 Samudrala, Sridhar wrote:
> >>>>>I think you should be able to get this functionality via the netdev-genl
> >>>>>API to get napi parameters. It returns ifindex as one of the parameters
> >>>>>and you should able to get the name from ifindex.
> >>>>>
> >>>>>$ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
> >>>>>{'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}
> >>>>
> >>>>FWIW we also have a C library to access those. Out of curiosity what's
> >>>>the programming language you'd use in user space, Joe?
> >>>
> >>>I am using C from user space.
> >>
> >>Ah, great! Here comes the advert.. :)
> >>
> >>   make -C tools/net/ynl/
> >>
> >>will generate the C lib for you. tools/net/ynl/generated/netdev-user.h
> >>will have the full API. There are some samples in
> >>tools/net/ynl/samples/. And basic info also here:
> >>https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#ynl-lib
> >>
> >>You should be able to convert Sridhar's cli.py into an equivalent
> >>in C in ~10 LoC.
> >>
> >>>Curious what you think about
> >>>SIOCGIFNAME_BY_NAPI_ID, Jakub? I think it would be very useful, but not
> >>>sure if such an extension would be accepted. I can send an RFC, if you'd
> >>>like to take a look and consider it. I know you are busy and I don't want
> >>>to add too much noise to the list if I can help it :)
> >>
> >>Nothing wrong with it in particular, but we went with the netlink API
> >>because all the objects are related. There are interrupts, NAPI
> >>instances, queues, page pools etc. and we need to show all sort of
> >>attributes, capabilities, stats as well as the linking. So getsockopts
> >>may not scale, or we'd need to create a monster mux getsockopt?
> >>Plus with some luck the netlink API will send you notifications of
> >>things changing.
> >
> >Yes this all makes sense. The notification on changes would be excellent,
> >especially if NAPI IDs get changed for some reason  (e.g. the queue count
> >is adjusted or the queues are rebuilt by the driver for some reason like a
> >timeout, etc).
> >
> >I think the issue I'm solving with SIOCGIFNAME_BY_NAPI_ID is related, but
> >different.
> >
> >In my case, SIOCGIFNAME_BY_NAPI_ID identifies which NIC a specific fd from
> >accept arrived from.
> >
> >AFAICT, the netlink API wouldn't be able to help me answer that question. I
> >could use SIOCGIFNAME_BY_NAPI_ID to tell me which NIC the fd is from and
> >then use netlink to figure out which CPU to bind to (for example), but I
> >think SIOCGIFNAME_BY_NAPI_ID is still needed.
> 
> The napi-get netlink api takes napi_id and returns ifindex, irq and pid
> associated with the napi id. You can then pass ifindex to the SIOCGIFNAME
> ioctl to get the interface name. So it is definitely possible without the
> need for the new SIOCGIFNAME_BY_NAPI_ID

Ah, I see. OK. In that case, I won't bother with the RFC for
SIOCGIFNAME_BY_NAPI_ID.

I'll give your suggestion a try next week after I make the driver changes
needed to support it.

