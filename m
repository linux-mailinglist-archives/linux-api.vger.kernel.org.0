Return-Path: <linux-api+bounces-837-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4784A1ED
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 19:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56D7B23431
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342A47F47;
	Mon,  5 Feb 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCT/kUWD"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A377481B1
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157027; cv=none; b=Ox0ZDzAEknBOMTMZ59PRl8YEegXgjs2t4G5NUTo+AL/nk/XrnzRLPr6dEVKybzPwzu8afN1PCD4Nb5hKxbC96KQNdAf10t3sHN0Gh/76/PYAsEt0FeLaHP2xDS9chUopdfussHdjr83jeRwrkwyC2U1/hhhya0dEbmUrfaU+fAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157027; c=relaxed/simple;
	bh=WyVS3Y2wCRBhfiMTdfPT7heMIJrKbyk5EHgpMoMjbXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lozBFWJsiYmYQm/rQzWklTEvU00Fwb6AEDBuun9ELvhhz8Uvpg9zwv5W/Ukc978VgN1pfRurrFmbVF9j/tKYh9ZHJRwUAPEg06rNRCq7FvmQgf5JYHpptc8UJ4JDbkqODfwH6L/1bdQRVcMN7bAj/dYeaji4c42pZzt3w8ou8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCT/kUWD; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e04e1ac09fso698706b3a.0
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707157025; x=1707761825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpapWswbA0phYqG7Th5JmIz/xxIayNN6qm0Enh+oczc=;
        b=FCT/kUWD25uZ0gg1xET6ny7c4DmMu/OEaK/P38ygp6BCIZQiF9ItGZYgWVHKle7+RK
         8jm6vl7nxpSJu7sE17h+WlhSrPnUvCKYZlKOd7MXDbg8FwgN0A3OK0HQDxQjqtM9kuDc
         eMjSK3ylU7PknTe5ct2gU5VMGceqTTVH0Nk4+uLOkvRyELMGNgdS1n4CF9BwDzzlE8Ux
         iBlqHuCoZo5TpWVotQcdNpm2mua6NtfJsDEVhckF6vF/HtDQM+FPJshDq2NhQMOUhnyZ
         jb4hIhRXo2N7+orHjME7OPc8IumDa7OqKs6oQZMbB50F7WUtfI9yWS+ODnO9iNP74ASb
         oT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157025; x=1707761825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpapWswbA0phYqG7Th5JmIz/xxIayNN6qm0Enh+oczc=;
        b=btKEP9hQD6NZ2HzNFDeJ2/DpeIDxv4wLipWMRaJBGMxLA7c5w6olboOzZfYRuaTjCu
         pNss9IK7cSidvjxqoIiNbF0VC3vkLciivAHLy0Eej//0wrhViDmiRypAyeckvGlQTq70
         OKiQqumfdd8wIeOO+IQBFg16X4fWRnhmkxkADf/mcGS+S/0nc8e4YICqkz20A3wEvWXk
         3b53pyo4DxiJlmBfVl6TsbWrqs1V6dEdYXyY4TLDbiaUygAbs+wx0oO9Uc1ak0cGGCcd
         RqULmd3JvhWqcw4wVpk+vVES9+G6D7BSUtHc8cNOU53dDs1f+obBNBQpdsBdrm718n5H
         zQvQ==
X-Gm-Message-State: AOJu0YzpQiehdZiLNiP0dgceDlZdsB3gLot3kKE3Kbwszebxd3v4S+W2
	PiaRVOtvwwOkh6yvDT/PXymxnIRid2ljTmjhPUsVgxcDBQVRvFW5yFQtJsNQ82bUYQ==
X-Google-Smtp-Source: AGHT+IGQv+TQK7y24BWAvs6IG/pyUZWoCNuAd9vOPrpIi7h6mfLRt251ituEeVc08meG2BCiMF+LKt8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:4f8a:b0:6df:eae5:79bd with SMTP id
 ld10-20020a056a004f8a00b006dfeae579bdmr14688pfb.0.1707157025524; Mon, 05 Feb
 2024 10:17:05 -0800 (PST)
Date: Mon, 5 Feb 2024 10:17:03 -0800
In-Reply-To: <20240202171539.7347cb01@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124025359.11419-1-jdamato@fastly.com> <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com> <20240202032806.GA8708@fastly.com>
 <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com> <20240202102239.274ca9bb@kernel.org>
 <20240202193332.GA8932@fastly.com> <20240202115828.6fd125bf@kernel.org>
 <20240202202344.GA9283@fastly.com> <20240202171539.7347cb01@kernel.org>
Message-ID: <ZcEmDz3UvAksHFFG@google.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, sridhar.samudrala@intel.com, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	Wei Wang <weiwan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>
Content-Type: text/plain; charset="utf-8"

On 02/02, Jakub Kicinski wrote:
> On Fri, 2 Feb 2024 12:23:44 -0800 Joe Damato wrote:
> > > Did you see SO_PREFER_BUSY_POLL by any chance? (In combination with
> > > gro_flush_timeout IIRC). We added it a while back with Bjorn, it seems
> > > like a great idea to me at the time but I'm unclear if anyone uses it 
> > > in production..  
> > 
> > I have seen it while reading the code, yes. I think maybe I missed
> > something about its interaction with gro_flush_timeout. In my use case,
> > the machine has no traffic until after the app is started.
> > 
> > In this case, I haven't needed to worry about regular NAPI monopolizing the
> > CPU and preventing busy poll from working.
> > 
> > Maybe I am missing something more nuanced, though? I'll have another look
> > at the code, just incase.
> 
> We reused the gro_flush_timeout as an existing "user doesn't care if
> packets get delayed by this much in worst case" value. If you set
> SO_PREFER_BUSY_POLL the next time you busy pool the NAPI will be marked 
> as "already scheduled" and a timer is set (to gro_flush_timeout).
> If NIC IRQ fires before gro_flush_timeout it gets ignored, because NAPI
> is already marked as scheduled.
> If you busy poll again the timer gets postponed for another
> gro_flush_timeout nsec.
> If timer fires we go back to normal NAPI processing.
> 
> The idea is that you set gro_flush_timeout to some high value, like 
> 10 msec, and expect your app to poll more often than every 10 msec. 
> 
> Then the normal NAPI processing will never kick in, and there will 
> be only 1 NIC IRQ after which the HW IRQ remains masked.
> With high coalescing timer you technically still get an IRQ every
> so often and interrupt the app. Worst case (UDP flood) you may even
> get into an overload where the app gets starved out completely..

Should we also add prefer_busy_poll parameter to EPIOCSPARAMS?
napi_busy_loop in ep_busy_loop has its prefer_busy_poll argument
hard-coded as false.

