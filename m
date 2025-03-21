Return-Path: <linux-api+bounces-3431-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B8A6C438
	for <lists+linux-api@lfdr.de>; Fri, 21 Mar 2025 21:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC4E464B58
	for <lists+linux-api@lfdr.de>; Fri, 21 Mar 2025 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9B2309B3;
	Fri, 21 Mar 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l5o0kxHw"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3E22FF5F
	for <linux-api@vger.kernel.org>; Fri, 21 Mar 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589050; cv=none; b=DyUeew7LaEORlJuLpVrYOHHW8OuuMnv5w76IkkNOyFM28Qx/J+oIkQmeXaHvhg3aEpk87BrqAPbaB2UOs0KANl2KBnMMWU+3+3RYGC3EjIs33jswLTgiEyE3PYNbzhAKhH67GrXA1ZQOIoMNeBPL1Cu8NBSzXAyRK8QONgIwd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589050; c=relaxed/simple;
	bh=kufjJ7ROxUIeeWBTf87pHaUYN0P9yN6f9l3gagdcYI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRXGjBZ+T8eja/6tA9EmVZOJFI6XYt3gW6V1B6afk2IxmJjRCpKTjvihsBHAB5IBk76uBScBfecincPzbiC4ytU8Nu8LZfffz78VhQgTYvX3PB0YZZUcrhOBKuYh7iymYQoWRd2kAVvubUe8i9jrSAFDQRVeegN5lccYU+26DjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l5o0kxHw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22349bb8605so57691955ad.0
        for <linux-api@vger.kernel.org>; Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742589047; x=1743193847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=l5o0kxHwz56/APvSz0yxxES3DtKjkGRzP3aHJgNtqfsPTeXBNyJqn9VNgMK3W6VEgd
         C3QYN/SUg1QAF8O7bGci/PkW/6tvRBw+3iE/xpWr29FsLghzQGbm9S5Ud3iooTfeENXt
         V1W51rg8ZwyivdKhNuOGhhAQIyBNtmn8MsF/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589047; x=1743193847;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=G7MTb6CCI7X2vAReM86sGmaz7pT9jZQMQbmKg33SpfYHTr0QbB5H8Kh6mRPn/tPmon
         7rO7O+SaKSknf6hm4iAXdir2oYNweoQczV54FuCNOfVdGHaViGarXXaSiA5ld2tuE919
         UEBok4XGd25KQW72X0PrDr7m9WJTNF5eQQGJL7x+/UharkA3pbRZGpcnscOtldC66otr
         r+NCJlsJ1VTVYsO0fNGg1347fx8hIrvwdCHp+xV3XLXdT6/VapSbtExCBIY/osZzQDYd
         9DUnmzQYSBAvBZvNX7WDsTcp4V3tFR7qERqNM6Dx/EYGPqNuD5MKAj9CSwqaJIfOGkrt
         I/vg==
X-Forwarded-Encrypted: i=1; AJvYcCXjF6aAaI3/e+GGSj/fDN3jMNYO9nP0q9QwpKgts3np9VspIEumStwwIr8PIi/JKnEpcdhMWnFhkzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpW5Cpqor1Goce0QcqrDKYA7UO7hAUffEQ/Fpc2kMVLoGWessg
	JATMEpktk1Uo0CV5pOwkJeX46NBO1TzhvE6FWVpSBEmZWy5Swvh7qulIQQkqEWA=
X-Gm-Gg: ASbGncvFiul6h+TG+f7vkx8orTsDLJA1BhnmdC8vgVOne801Ctvmw2tKBW4oGKlLIJJ
	jdmjoSZbe6NJDf48JP+R8/47Zll1urX4KaikALSSgkxuafUwSGguYi5CITcS7SQupQIHptyg9cw
	jSumUZUuIcaF3+TzWVswYQLaOleRRJiHuh2MwGuVTFpy/JSdmMGr0APiIBquXiLvuLqEDaV8ED7
	13K1GkGMO7GorCpD41n1DwOTsq1qdtkb3MeN7yR34wBZJSPGGscBAioOeARIJKN5V2R9YfaN7p8
	bTEvwU9Iw7H+yZn8F5F8iAii816Xov+G+zwnh0Bh8JEtvUxJ+y+uWVy4neRcIgr4mHwZzJMWe2J
	xDct6Kky/5s16WghY
X-Google-Smtp-Source: AGHT+IE/0vRvWUIrCU9TpLfmE4aooUPQeYEWA/MrsW2UXdaB42a9j/XwGhSTptf5SM5XxL22FRt0Ug==
X-Received: by 2002:a17:903:41ce:b0:224:10b9:357a with SMTP id d9443c01a7336-22780e3fbabmr64649685ad.32.1742589047213;
        Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2aefsm21875045ad.109.2025.03.21.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:30:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>

On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> > On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> > >> I don't know the entire historical context, but I presume sendmsg
> > >> did that because there was no other mechanism at the time.
> > > 
> > > At least aio had been around for about 15 years at the point, but
> > > networking folks tend to be pretty insular and reinvent things.
> > 
> > Yep...
> > 
> > >> It seems like Jens suggested that plumbing this through for splice
> > >> was a possibility, but sounds like you disagree.
> > > 
> > > Yes, very strongly.
> > 
> > And that is very much not what I suggested, fwiw.
> 
> Your earlier message said:
> 
>   If the answer is "because splice", then it would seem saner to
>   plumb up those bits only. Would be much simpler too...
> 
> wherein I interpreted "plumb those bits" to mean plumbing the error
> queue notifications on TX completions.
> 
> My sincere apologies that I misunderstood your prior message and/or
> misconstrued what you said -- it was not clear to me what you meant.

I think what added to my confusion here was this bit, Jens:

  > > As far as the bit about plumbing only the splice bits, sorry if I'm
  > > being dense here, do you mean plumbing the error queue through to
  > > splice only and dropping sendfile2?
  > >
  > > That is an option. Then the apps currently using sendfile could use
  > > splice instead and get completion notifications on the error queue.
  > > That would probably work and be less work than rewriting to use
  > > iouring, but probably a bit more work than using a new syscall.
  > 
  > Yep

I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
through the error queue notifications was OK and your response here
("Yep") suggested to me that it would be a suitable path to
consider.

I take it from your other responses, though, that I was mistaken.

