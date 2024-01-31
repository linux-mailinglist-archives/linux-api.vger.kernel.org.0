Return-Path: <linux-api+bounces-765-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D1F84344B
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 03:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C9B1F25A4F
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5463EAEB;
	Wed, 31 Jan 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="dBeaOm4U"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60AFBE1
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669841; cv=none; b=Ok9Z5yruoiz2flfQv94jxbMQDsvVr/fUFpHgxQMykowgznM5zF+O65x5q4ETP7halFcT4Rn8dziOj0Qds2lNBfRNYrrKUohCoLueAIuwCORvqVESTignK6ulGExXLDQ1WhjjRl2F43RuRgXWWCioyBc5YO1QsTxZvVaeZhuXi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669841; c=relaxed/simple;
	bh=VgPYXUVCWMjDrC8yROV4FHibG7ows0RrAJ5ioytMUwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+/DLW649+Il+ruezueQpbp7FkCWQPyYnlEZk2NxCXP8699GlsaRh/XroMCyMiF1Gji1cHBGxJ2KtcypkSCmBbPki08rjqfT39XGgWfMtQR5BCwpgI55Lb3IVXK+t7nP8t/PtM9rb2UIUgt1fE+RUVfPRNpNzoVZGSzlVhLICHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=dBeaOm4U; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59a8e73ebfcso112287eaf.0
        for <linux-api@vger.kernel.org>; Tue, 30 Jan 2024 18:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706669829; x=1707274629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbQ/cmABBf8PD8bdQqtTiunaVcAC5Mi3yix4/3wHqHA=;
        b=dBeaOm4UWy5AaxOxacMsxA0KAgPJthBmXUiQR/GIsIp53N5h0Nnwih/qvdVe1/RZBW
         Og8G41wYDX7tHxC7szLHNZdKKLhxnm50O4/5aqfCazo6d53g0ircgSXtW2eXlcG5lEB8
         oxmMJBBc/FWV5DfsTOWotrqHSOqd9JJRZtzX3vYwV5ZtN9U9u94VYQ3Oi2HwngqeUCnE
         rJshlyaygWQIvTrMAs9CkUu4WeKvrRkTt8VtCj7KIIveqt2FLzW6jim0reT2cAElizGG
         iSPkLhnKm3QgVvspisApU/D8r30j7+aKZJYhWS51wi89eAOzwmMiF2Icv82Qeb/IZzp8
         5hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706669829; x=1707274629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbQ/cmABBf8PD8bdQqtTiunaVcAC5Mi3yix4/3wHqHA=;
        b=skyusEXZBHPBvODgKgr75/+OXVhN9UO4jd74AEQvtKWs6OggNH+1i67vL8e1G7x/Nu
         t74NIyIds41nzpc/mDRJiOWtG3zd+8shtCbxNpVyTzDYKp3TVs++WXbOl2SHYVMx4A6I
         bzvsMj3Lr7ohReQglNggnp7CW/M42gREtluq0D8j3qgJn3hsP6XFOlywBpbF7vSjkxRT
         4YSS6fxCwEpQ/0B9DO6XJfcO9edgnr9HS99hBNaxPy+kDEvXQ5dE2eW6zJIdgiO6MLDg
         JUnNOuqtxMs7/pXcSMTudhnDJiKXl0KjelHSFWZM5mAG6VgZ/nbx2BptE10wQIlKqlxj
         9E+g==
X-Gm-Message-State: AOJu0YxX1tFO9f50W4cP2uKH06Y7H5YbuWaNBFKgGbLfcz1JqXmLee4B
	mSfPCLDO7YdiI4YTnYAuIjx/uqLyNWTjKCjifPgW8zA8xnAhYfsiU+iLcuZqSC0=
X-Google-Smtp-Source: AGHT+IG9K2V19sZuctdZBL4AhF7KafbZpTSmId1sbYMWgHM7klLehsRES8IivEcsfheskPe4H34+3w==
X-Received: by 2002:a05:6358:7e14:b0:178:618b:89bd with SMTP id o20-20020a0563587e1400b00178618b89bdmr119841rwm.30.1706669829230;
        Tue, 30 Jan 2024 18:57:09 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id d13-20020a63d70d000000b005cd821a01d4sm9196297pgg.28.2024.01.30.18.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:57:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rV0mf-00Ha2x-0d;
	Wed, 31 Jan 2024 13:57:05 +1100
Date: Wed, 31 Jan 2024 13:57:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Joe Damato <jdamato@fastly.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	David.Laight@aculab.com, arnd@arndb.de,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maik Broemme <mbroemme@libmpq.org>,
	Steve French <stfrench@microsoft.com>,
	Julien Panis <jpanis@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <Zbm3AXgcwL9D6TNM@dread.disaster.area>
References: <20240131014738.469858-1-jdamato@fastly.com>
 <20240131014738.469858-4-jdamato@fastly.com>
 <2024013001-prison-strum-899d@gregkh>
 <20240131022756.GA4837@fastly.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131022756.GA4837@fastly.com>

On Tue, Jan 30, 2024 at 06:27:57PM -0800, Joe Damato wrote:
> On Tue, Jan 30, 2024 at 06:08:36PM -0800, Greg Kroah-Hartman wrote:
> > On Wed, Jan 31, 2024 at 01:47:33AM +0000, Joe Damato wrote:
> > > +struct epoll_params {
> > > +	__aligned_u64 busy_poll_usecs;
> > > +	__u16 busy_poll_budget;
> > > +
> > > +	/* pad the struct to a multiple of 64bits for alignment on all arches */
> > > +	__u8 __pad[6];
> > 
> > You HAVE to check this padding to be sure it is all 0, otherwise it can
> > never be used in the future for anything.
> 
> Is there some preferred mechanism for this in the kernel that I should be
> using or is this as simple as adding a for loop to check each u8 == 0 ?

memchr_inv()

-Dave.
-- 
Dave Chinner
david@fromorbit.com

