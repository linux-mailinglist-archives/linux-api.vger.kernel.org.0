Return-Path: <linux-api+bounces-2043-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D894A940186
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2024 01:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161AE1C21C7F
	for <lists+linux-api@lfdr.de>; Mon, 29 Jul 2024 23:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3B18E75B;
	Mon, 29 Jul 2024 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zZGkFNgY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973318D4DF
	for <linux-api@vger.kernel.org>; Mon, 29 Jul 2024 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294490; cv=none; b=oe3nWT8HmuhhZFtNekU5ZJA+XAxY6o0tLOb5DcXgkTKpSIfePWn1cQUaaHRfc1LChJL1HupvFVQ1vc5tAZTbbtnIiHG56ypL8RgB4N2geFXlgAj8l96rggYZ36h0ovm+rYrB4Dl6841bNT1pNYNRaXS5CHjLe0YTA2e+dwGZhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294490; c=relaxed/simple;
	bh=nkaikTFUlSmX3DhO1KpnWb/Z+fKdpA1YmRexhFEeM5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK0d595lhiNJOZ7fyUuBlTW+6VsGXXnhF+TD4H1yyZp6PtJ/BHSikn9CK8qxVaLMxdlY00FSOKvxiUOvQ25ww1qolDCnGZuzu4/mnr1jvKFoJkSewRj5HXnkma1VNm4HG6Pv3edTyXU2nkXsq08aSFNal++KLUs4RUP83jRu5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zZGkFNgY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso2687974b3a.0
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2024 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722294488; x=1722899288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0LGTo3Y3m1DYT/L064NdzKpJDb4dkxyq3jlUEWujtw=;
        b=zZGkFNgYvzzuXrCbWxBUIxiDrEwnakvMTDb0y4cBD0KVUGBuWGjbyI9GGvQDHcyj5E
         igCYWO7oJRCNo0gB0VnWBSfjEyUMUEHzFs3C0Mt7CC7f8nqI+LuFy+UpMWdWhWayegPN
         gizEGSsyv9Ag+HyaBWZRCCQlObkUBf22IzetK5olxfhFbQKC4DxaeNoJWx6RXV0RkKt3
         1NQZmW5fe1/5r9hxY7HDoZ+/nEE9q6UrYORZa5Vk2cKZNUePP3dJPT4bmS9T9fEPHPbl
         qKdgbhuVNc1YZ762F9IACkWGMm3NlGLZjzOgQ8wYImsC4ueCuiaLbhC4zg8KalQ3l3ng
         OxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722294488; x=1722899288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0LGTo3Y3m1DYT/L064NdzKpJDb4dkxyq3jlUEWujtw=;
        b=Y8r0HbxU5GSj5fLf3nyqexuGtn4hFlxsUJQZsfcG1IzEePZyN2OUuwKDWyJ/7pxplS
         joMBgJEnu1QKoGy0d2jvPGIXvWqA4py6KxLsolGpSKOBhgwtHQFLd0jS1rfN8kIY3jvH
         X7h+D+NjILUQLaA03IWkQTVpiODfCe7+WjvZGxpdNfZOlbW8z2Uq4jqbtwWvoQNCW8fr
         UJMAtWfElvG2sBAnqJndF1pJXUihODA6RoU8q8gCsXGv7ol72W6QRHwOa2pcYg680P0a
         3c50WmNZbIGCQQuVB7iiLjH6pyuomYcZTdzf/mqcJoYIL4ZNi0ZRqdSAO+DIFp5o67k7
         CiBg==
X-Forwarded-Encrypted: i=1; AJvYcCVJvIIPFZa4dH8US+P+f9ybayCUv+A47v7Qw3nVyQ4LDdlZows9u2v2KXgzUOU60HrGCaN27u5//a4QsHekEvT8922e5vkycop0
X-Gm-Message-State: AOJu0Ywucj3TW3Epj7c6JsLmK4Rm2LQna9vdSnENiGeQivi+UTecXxmT
	b647h74g/eaOYkC/1RXYhQuvrNn1xECeEI+OhBdk+rXtPLI2jO+2/bzet37lVkM=
X-Google-Smtp-Source: AGHT+IF4yFB7SHKt3Co4VrPrUq/OiI1/SU/9aa6/HrVKHdg+3npIMDwvHwWJoWmiUNqso5AcYSLxTg==
X-Received: by 2002:a05:6a20:3d89:b0:1c2:8949:5ba1 with SMTP id adf61e73a8af0-1c4a1529b50mr6652384637.53.1722294488250;
        Mon, 29 Jul 2024 16:08:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8af074sm7303132b3a.218.2024.07.29.16.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 16:08:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sYZTJ-00G40t-0V;
	Tue, 30 Jul 2024 09:08:05 +1000
Date: Tue, 30 Jul 2024 09:08:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <Zqgg1Z9GvPZR93WC@dread.disaster.area>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com>
 <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sevspit1.fsf@oldenburg.str.redhat.com>

On Mon, Jul 29, 2024 at 12:57:14PM +0200, Florian Weimer wrote:
> * Mateusz Guzik:
> 
> > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> >> * Mateusz Guzik:
> >> 
> >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> >> >> It was pointed out to me that inode numbers on Linux are no longer
> >> >> expected to be unique per file system, even for local file systems.
> >> >
> >> > I don't know if I'm parsing this correctly.
> >> >
> >> > Are you claiming on-disk inode numbers are not guaranteed unique per
> >> > filesystem? It sounds like utter breakage, with capital 'f'.
> >> 
> >> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> >> local file systems are different.
> >
> > Can you link me some threads about this?
> 
> Sorry, it was an internal thread.  It's supposed to be common knowledge
> among Linux file system developers.

btrfs has been dealing with this issue since snapshots/subvols were
first introduced some 15-odd years ago. This isn't a new problem...

https://lore.kernel.org/linux-fsdevel/20231025210654.GA2892534@perftesting/

> Aleksa referenced LSF/MM
> discussions.

I also referenced those discussions and the -fsdevel discussions
that have been happening for quite some time. I'll reference some
of them here again, because they are all out in the open....

https://lwn.net/Articles/975444/

https://lore.kernel.org/linux-fsdevel/?q=st_vol

https://lore.kernel.org/linux-fsdevel/20231211233231.oiazgkqs7yahruuw@moria.home.lan/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

