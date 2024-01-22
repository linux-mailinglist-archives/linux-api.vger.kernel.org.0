Return-Path: <linux-api+bounces-562-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3383751F
	for <lists+linux-api@lfdr.de>; Mon, 22 Jan 2024 22:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA61C26812
	for <lists+linux-api@lfdr.de>; Mon, 22 Jan 2024 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213DD47F71;
	Mon, 22 Jan 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SaiTxQdK"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED547F64
	for <linux-api@vger.kernel.org>; Mon, 22 Jan 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958182; cv=none; b=Nsxu+c1r7Jn4qSPs7NiwlWIikRHuR8D5PNJRn9qyxhQgzNt4nyxQ6K6tF5E17WLeBhLmj81A5KzKQQMQ7e/FlRggU6ZmClUm/8y+9ZB/n0VWzU8hu0RW3xdhzMdFhvj5nfgXv6xbCEmUDoSjLid/Py+/FKwjeK+DFUw3eLTglQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958182; c=relaxed/simple;
	bh=zMXc6tor4fJWUFbxItJ2+5r+CRBPP2/dvta/6uILgnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKpmXr9QdlTfizeNoSR15nzgqJgXCwvAIAX31gCrjuyI5qPTa8iImaimffo1P6FSaKrJpKZZameUhgn7VjZjv7kuBQL3Vqtnf7szKl6DdIPXRWkEkLS/gD0i0t91aufRIMTZIpcHSeag3I0rzqR8579qvZZyN4cCkoWwmL2L2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SaiTxQdK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71207524dso12484385ad.1
        for <linux-api@vger.kernel.org>; Mon, 22 Jan 2024 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1705958179; x=1706562979; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK/doAZyyGzQuUQ64pMN/IegoB0Y5GZJ/6bMRTJUZOs=;
        b=SaiTxQdKSvdfDHf7FsAVB4Up811/prozfadikTlsZcpgqyu//7JGkD7lZap1WTv3/3
         zpsWEw/NFgolwwJgdoS3CQWtu6WWaltSUmnndO6I1eDYlP4mLNvPCOQ1U/7X2VPOVZCg
         mITcET3n22GHWVgtPIu4buWcJiSXEc5lOA120=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958179; x=1706562979;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK/doAZyyGzQuUQ64pMN/IegoB0Y5GZJ/6bMRTJUZOs=;
        b=J1BlaYPGAaWK1SLSTdnFNtBqNm/CBB1JseZ2K8Fk5DBl4Wflmg/qV7hvpJWNRmrMz7
         d2FC2BKpwZFZrMrSTf4y5vpG8+U4BXAZCtJzI5mb3BDVzjwpOjl+lQyFFGBMsb/cZpKT
         1EeocIJjIRPJ/B+dFwHkjQVWdNX1zIo2qSp38hN5um0m3MFj3BE2EiKVWQg737k+J7Fd
         NrnW5KfWKZmtxZAGo9Q+OCK3USAKeo8dwrzhwSwLeIHKadUXg73bxVd5ZvHXILpGUCuI
         eAudUeiRkz8bAGCkfu1ntWugb0clyH/rW4Mw6zzYcsJwmjfPMGzTaSCnFoBSEvc/zwb2
         1Vag==
X-Gm-Message-State: AOJu0YzwE3NsKXZal861rQjtYyKNSlYxhPsYZNaBvcN+P7cZWxRJ6UII
	jpjbpcniZhzEo4e1Jov0Nd7tKnvFxRFoq542mDhKZ8tX0WDUYBT0iLXDABfpvDuCw8zSrSVVff8
	k
X-Google-Smtp-Source: AGHT+IHY6QTp3+L73kbC1yAy2VNJUlYykSfBPUTr4schnUh02OhLk1d1DJUhybB11UylKM92YKo7RQ==
X-Received: by 2002:a17:902:e891:b0:1d7:599d:ed25 with SMTP id w17-20020a170902e89100b001d7599ded25mr1272345plg.39.1705958179526;
        Mon, 22 Jan 2024 13:16:19 -0800 (PST)
Received: from fastly.com ([208.184.224.238])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902b28400b001d720c7ed48sm5693728plr.286.2024.01.22.13.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 13:16:19 -0800 (PST)
Date: Mon, 22 Jan 2024 13:16:16 -0800
From: Joe Damato <jdamato@fastly.com>
To: Christian Brauner <brauner@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org
Subject: Re: [RFC 1/1] eventpoll: support busy poll per epoll instance
Message-ID: <20240122211616.GA1244@fastly.com>
References: <20240120004247.42036-1-jdamato@fastly.com>
 <20240120004247.42036-2-jdamato@fastly.com>
 <20240122-erwidern-erleichtern-8a04080a4db3@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-erwidern-erleichtern-8a04080a4db3@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Jan 22, 2024 at 04:25:01PM +0100, Christian Brauner wrote:
> On Sat, Jan 20, 2024 at 12:42:47AM +0000, Joe Damato wrote:
> > Add F_EPOLL_{S,G}ET_BUSY_POLL_USECS to allow setting a busy poll timeout
> > per epoll instance so that individual applications can enable (or
> > disable) epoll based busy poll as needed.
> > 
> > Prior to this change, epoll-based busy poll could only be enabled
> > system-wide, which limits the usefulness of busy poll.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> 
> This should be an ioctl on the epoll fd, not a fcntl(). fcntl()s
> should aim to be generic which this isn't. We've recently rejected a
> memfd addition as a fcntl() as well for the same reason.

OK, thanks for the review. An ioctl makes more sense, I agree.

I'll rewrite it as you've suggested and send another RFC.

