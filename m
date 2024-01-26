Return-Path: <linux-api+bounces-672-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1883D15C
	for <lists+linux-api@lfdr.de>; Fri, 26 Jan 2024 01:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85355B268DD
	for <lists+linux-api@lfdr.de>; Fri, 26 Jan 2024 00:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0C63A;
	Fri, 26 Jan 2024 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SLpqS0QE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E8637
	for <linux-api@vger.kernel.org>; Fri, 26 Jan 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227894; cv=none; b=R63BxQC0JX6c/mgAiHMqLldvsMUDKB2DWwYLwZlunIWs6s5MRjARNajfOsFBlCXtnVGlXJvVgzM45IMDYQa1Hmm6HSCNBojl3sRWYbRuAtJ7hF+o4JqKM9FE599qOGVvQQh3aph5bgIj8j65LvodlhTCOLzedX0SCjQD8K+ePp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227894; c=relaxed/simple;
	bh=tS1D/gC3eczV4hc9F7HIorCotTTkm6mnvxscD4v6Lmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exhSYh568znXmsiUYFuPxxygd8Nl7wXIZRcKc/U6dwpqOVryZ4+8Cv//8wW85t/JqcWArMRQbpQqF9S4Re8LnzVA5vw9qSuPGOPsq8rxAqVEXL/+AdZWRfMvAE26Wm9bXSEtwugdZLz0vBJUnrye5ZtRRtFXPHIDZ3h5W70DFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SLpqS0QE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d746ce7d13so42902575ad.0
        for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 16:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706227893; x=1706832693; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GloqAGaE/8Xt5EH+nEjxDsFciv6uGLru4K2wOJLFbuY=;
        b=SLpqS0QE4w8luvxKbPVs2v4sG9kn8FfJ5NXxIFbRIQSvf5cDB4lSzet3I+FEf6DH6k
         Ya4COsKKQjC8B0wvlVvLpmI3NuhfaMh1LzQE4ar1m5np4jmPDIftq1T8QG4lzO7YXx1b
         MgGab/TqBd6SZa9Wsvjbc68+8v8NB0nHsqBlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706227893; x=1706832693;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GloqAGaE/8Xt5EH+nEjxDsFciv6uGLru4K2wOJLFbuY=;
        b=g9fMDt0mhYU+mHCheHenhrOuItjKxZfM5bpsepS3e0aU6P3QFL/nkd4ZWnf0vB1PPG
         OidVF+IZVyBkP0oejVQxp0SpL7IOZhFOmO3HQF9rIGararUOymdu2NIpv6HLwBCN009c
         8s3mGPs9EB5JyGqGKNY+LAp3kJe8WB+xWQHzP5pn+iuaLWe013IaIF6C5mJFrAjukozE
         Hzm+jw4npyt2agG9povA/AO/FZcUPX0/4ldPfIxIsPohpnvcSPYbYt1rW/daxTUoT4N1
         4HfgS2EQ8V02b3KdTLvhZu+3YXovs+wQpD7LX9I1dEGhOG3zeLWjnv3Tz55Nn3t6x9SM
         Zslw==
X-Gm-Message-State: AOJu0YxkoGeKrIQJaQ7txs4rvOZ3Db/nQ+r0pbLh3ATE0xiRKHopAGvt
	CFs/XSnjSGUzOf3enLqh/iacCkuLMOLubKsIkZPMQOWz4dWdb4YTQPVpJOf+HOI=
X-Google-Smtp-Source: AGHT+IGBb/9rSx28R5bqGae1Ih6pLXBUZpviP2v/EZH+ry1x0sFiesGEC78wJnmgSEFLUxy3GHYlvg==
X-Received: by 2002:a17:902:6509:b0:1d4:868b:7ccc with SMTP id b9-20020a170902650900b001d4868b7cccmr455778plk.111.1706227892703;
        Thu, 25 Jan 2024 16:11:32 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id mn7-20020a1709030a4700b001d49a08495esm66286plb.118.2024.01.25.16.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 16:11:32 -0800 (PST)
Date: Thu, 25 Jan 2024 16:11:28 -0800
From: Joe Damato <jdamato@fastly.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240126001128.GC1987@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012551-anyone-demeaning-867b@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012551-anyone-demeaning-867b@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Thu, Jan 25, 2024 at 03:21:46PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> > +struct epoll_params {
> > +	u64 busy_poll_usecs;
> > +	u16 busy_poll_budget;
> > +
> > +	/* for future fields */
> > +	u8 data[118];
> > +} EPOLL_PACKED;
> 
> variables that cross the user/kernel boundry need to be __u64, __u16,
> and __u8 here.

I'll make that change for the next version, thank you.

> And why 118?

I chose this arbitrarily. I figured that a 128 byte struct would support 16
u64s in the event that other fields needed to be added in the future. 118
is what was left after the existing fields. There's almost certainly a
better way to do this - or perhaps it is unnecessary as per your other
message.

I am not sure if leaving extra space in the struct is a recommended
practice for ioctls or not - I thought I noticed some code that did and
some that didn't in the kernel so I err'd on the side of leaving the space
and probably did it in the worst way possible.

Thanks,
Joe

