Return-Path: <linux-api+bounces-839-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE884A2B5
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 19:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E49282B83
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F25481AE;
	Mon,  5 Feb 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kI10tHfW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC289481B3
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159096; cv=none; b=IltbRHSzy0HGAXvewNLik3pdDwYM6l7I82waTnyJe6eH8Ehg3d73PUAPKFykD2/+SawxrIWTNAWCiCXVBlqRKJhZNsSb9gYO2A4JT8z9/3imO7LgM/MLSbYmYGrMx+2UQTQdHFNaH9FyKKvoCBdKPeNcnxDSk4J6xZV/amDwnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159096; c=relaxed/simple;
	bh=YRLvcN9CSCBV0BFZJgyI3M9B7d5hDjTdl+eOK8xw9TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhJ7yp/4MTcYh/cxrB/0yO3aYlOMquyWRLUyPWqfNQKjrVZoF+hJgfITu/inzM8hxhTMNtnY3dcd1uQYdQbUUDVMZDIBrXcu0SscqY8O2COeZqR1aE/AEtYAJ5PL8X6M2KmjzR5DRPoZuvapE3krlGYGgR/TGIltNorq+70i0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kI10tHfW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so3083181a12.0
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 10:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707159094; x=1707763894; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOjV1gXJ7yW6QwEyKkVtGPB0y6fpvUh/vBUx9bdiItE=;
        b=kI10tHfWp4zAEYeu4x2+QcyIuhYCJtNhOjd077+nYImca8UtTWhi/c0Y7/ik63Y1hj
         YIkwA0zfvrUryjfEDAP9wZ1FwAdmHJlO0jr7kVUVF+N+lU2j/oJw1rMjCPdsxQVS2Ea/
         Nzn9vx2Bd2/8ouojdXpZah5q9XNLa0Lydghag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159094; x=1707763894;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOjV1gXJ7yW6QwEyKkVtGPB0y6fpvUh/vBUx9bdiItE=;
        b=Iye2NOwZbN4I36uzu9IJXXFOLpXableH/vhIR5cQPPKxo9WSQ5Fincp/xZBir83rWQ
         wdkUIP4i39Wm9vr2VH1W2to91pGWGNbp71sSKTXiyWCW49pCea6GvyLOSlEC2O/UFcYI
         0j94eiZwz/j+zmKcn95L5D6J1zEFQ1FrQGlY2INj4V2b0JDf7LZ0CKi9GPhDaeJqzgLu
         bqzkpo74MrXYRhrLkMon0iXcPM2ULgD/Oebyrjb8snMqVMGsuBViI1eg89k9p+GV2k2g
         i73eDzATdI7mIgo8EhpeWSnUaeT3ObmQIDllrT09F3C62de/3sumKBEz0lJB1xnjwuQ6
         WvqA==
X-Gm-Message-State: AOJu0YyaPam4FZz6zarbKBdn0HRdCj/fyORSrTa2aBYp+YEzk6cCoDit
	W+42ydVy3emDwg06X5FTX+7/E5IU1M35L28lc7HdXfUdEdj0pWGB3kgi0dm+x6A=
X-Google-Smtp-Source: AGHT+IHpVFCNoHwA10pfYXFqdcT5vM2l0+xFNFBhTBQjKZ74TWGiQprOTFulXZSLL1k7B78D0T1ZRg==
X-Received: by 2002:a17:902:ed45:b0:1d9:2a26:d4fa with SMTP id y5-20020a170902ed4500b001d92a26d4famr442390plb.50.1707159094008;
        Mon, 05 Feb 2024 10:51:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUV92h4DiOCBdCc6zj1PuI/ULHWjgYrzV4rTNn41DCqn+B9x6eWVUrk+ADYysx+vyi309dzHSfqjSiHER4MNGQ5IYQXaT78BDBQQ7ynb1H9CUhL1TVlrosSS7f1t8+JMnb6+7MBsbzaq7SmiwwEtIF2GTDiqOUCFjrBQll0xW7eDRXq9vjCUe3Cf6LzbGDxtpzQm0n7BI4p4tC6u/6px8l0sIUMMc1f0V8G9eB8GDbxox1beqo/1/M7d/aaRo9R76v72riHGX5wgcqA1C1jcEliFQcaRDYOX4N8pqADGcvq6hP1U5s6JmxvX2AMifpzDM5kdugY6DffjDfMfR/LuUjLZNuUt83rDKPnFWyN0uwrS9Z7yTx6cJflff5Jbrndl/+b+9TRRGDJs3FUUIYOTH6KMqo=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001d958f8ab2bsm195912plg.107.2024.02.05.10.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:51:33 -0800 (PST)
Date: Mon, 5 Feb 2024 10:51:30 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, linux-api@vger.kernel.org, brauner@kernel.org,
	davem@davemloft.net, alexander.duyck@gmail.com,
	Wei Wang <weiwan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240205185130.GB10463@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
 <20240202032806.GA8708@fastly.com>
 <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
 <20240202102239.274ca9bb@kernel.org>
 <20240202193332.GA8932@fastly.com>
 <20240202115828.6fd125bf@kernel.org>
 <20240202202344.GA9283@fastly.com>
 <20240202171539.7347cb01@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202171539.7347cb01@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Fri, Feb 02, 2024 at 05:15:39PM -0800, Jakub Kicinski wrote:
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

Ah, I see. From my reading of the code in busy_poll_stop (which could be
wrong), defer_hard_irqs_count must also be non-zero to postpone the timer.

Is that right?

If so, I think the tricky thing with this is that these settings are
system-wide, so they'd affect non-busy poll apps, too.

I think in the ideal case being able to set these on a per-NAPI basis would
be very helpful. Maybe something for me to try working on next.

> The idea is that you set gro_flush_timeout to some high value, like 
> 10 msec, and expect your app to poll more often than every 10 msec. 

Yea, that makes sense.

> Then the normal NAPI processing will never kick in, and there will 
> be only 1 NIC IRQ after which the HW IRQ remains masked.
> With high coalescing timer you technically still get an IRQ every
> so often and interrupt the app. Worst case (UDP flood) you may even
> get into an overload where the app gets starved out completely..

Yup, this is true. I had been using a modified version of a patch from a
research paper to avoid enabling NIC IRQs [1][2], but I think making
defer_hard_irqs_count and gro_flush_timeout per NAPI parameters would make
more sense.

[1]: https://gitlab.uwaterloo.ca/p5cai/netstack-exp/-/raw/master/kernel-polling-5.15.79-base.patch?ref_type=heads
[2]: https://dl.acm.org/doi/pdf/10.1145/3626780

