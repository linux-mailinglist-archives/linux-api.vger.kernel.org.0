Return-Path: <linux-api+bounces-3182-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8FA30FAA
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2025 16:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F91E1885C4B
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B060253332;
	Tue, 11 Feb 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H319oK41"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEBF254B09
	for <linux-api@vger.kernel.org>; Tue, 11 Feb 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287453; cv=none; b=gv9I3nORiSLN9k1pE/15rhbz/RZbjSeW9tYetNnlUhkEOYZsU9JYWBBvTMukyCsqt4BkuvMztLC5AfCxJNB1Hgl0D0guOKwm1vMD4iNDSJqw9frUf4zsjD7hV3SzqhYUWDeB7Qlh0b1F0Lm1lk1uJZ+kvuyyx0KOjYJf0JmGtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287453; c=relaxed/simple;
	bh=jdMdgLerobsP+yMcSdARJ6BtI8zGEUAwkq9ZKb+/l68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAdHlyq2O3pYb4oFei4rEWM/tRb3OSB4H/g9/quWtKhbDyCEYVN56W35bY4YkwA4b+dluqDaFXdf+vfvxbhTgKJ6TKs9eOUQAWMTRrbKirPWdhdG0ys4VFJFUn1chC34u3okXBlVJ5+GU2iFRtYDF5lnd1BOyBKpXC8E1MPkhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H319oK41; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de47cf9329so7093563a12.3
        for <linux-api@vger.kernel.org>; Tue, 11 Feb 2025 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739287449; x=1739892249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBvU4Dm8bwzLR9Wj8jIUktjjWFEcu/PHjQzCficyKJE=;
        b=H319oK41WqIiB3iRZc10DwubNF8cPsHZCoAU9H9l2gGcIX++SEErgJk47fZWBuMBFC
         IqBas9xi/IpQv0Ox106bjQpUoPYzeYhBRuaYr/xMZET/aAx42kcUa+ef2m4Ols0Qcvct
         Edf8cyBG2ZDhbS1Fty0NdRZ1rCsjVdENc00qpa95QV5CUrWAQg9aWN7+wqj2xYlz1x/G
         JddRrrlmrVUQvlhOctZEBEanWj9fSSaVXqprrGf6afTAoyaB3SuXpHD/KK12EgOTIJ9T
         ckpcL70djZvyuf3SXQdiMZXCf+Yy+wdBsy76uKMPlg19vxRZs/OC7fdSq1EsLu8AU9Hi
         ZE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739287449; x=1739892249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBvU4Dm8bwzLR9Wj8jIUktjjWFEcu/PHjQzCficyKJE=;
        b=gJ94jL/TmAMbLcFFx4k1AE/sBPpHEldCnKdp/m8a6T2bYgKriBk3UKEG7wEYp9uoDQ
         CEvl7xNMeGh+Na1hk8Bq92NfYwmdyni/iwXGJJi7uI4csK0cJL2ICdCTFiM/lY/D0P9T
         p40PW/fZbfVZVMFwUcI6sOlBTTc5DfZ9kj/DTS808vGjnAuJpRXLry6uSkZdTAP3H3A2
         zl4s3SL345UZxPmZTGWf0A7qRJ8H7NkWjWxYaTVBZNBe+2zQnEFRGyEHdAlkDAS6aYyU
         jGfSWN4MiLltBSj35yDJhmWwFtHSXFHl8ni5B2pxTECdo1i7zjBbvI5skdjUl3oAc45V
         kALg==
X-Forwarded-Encrypted: i=1; AJvYcCV4eAlQThs6i9j1WQICcVyfQX9tSsZBgsh0NzToTxJATPeqxci/1tFyX/m7LRF2xUwm60T8oQUrd6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LJUG65iaiOb6qivgTzRVs8vleIZ8rXVbKyXF1V90pe94Ho4k
	PXtbgTHN1rxBx9gFIoJW5iBKXs3skWvMfKGxIQlgRTrVPbYNgy8ia1MMirDj8hc=
X-Gm-Gg: ASbGncsxpyQ1DET2TVydA2dnbu44QZp6Q4oHzJajgKJpRjf6VipxAF1ryU3b7tbpAtd
	D6+wSv8FiOxWU/RNiJm1hszsyETfjkW7sB7MhbH41UanubTVQtQe1sTeGQ/KUBu/3wrncnx1jo4
	dlLiS0dwL+E2ampRK1lGRPULCUj5ydg5nVAFwDZg2F1aJMczSbImTmLtdo2Wfn1co7WdIZ9AJ6L
	1apqLKDwme3XEwavf4ipopmAO3UD/k77Jlab7FNnsh6PiKDfgpGf0h3mXemxBZrswhJmgGynP6i
	IeR7hZ927ObuYgNu/Q==
X-Google-Smtp-Source: AGHT+IERX4U02RBjjELzamqHtVUVOA9PKYON51fVOHE8xRaV3mjjYDHIg8FH5jXIOBBQliZ9fehckw==
X-Received: by 2002:a05:6402:4605:b0:5de:6bc2:7bb with SMTP id 4fb4d7f45d1cf-5de9a3dc37amr3981363a12.17.1739287449386;
        Tue, 11 Feb 2025 07:24:09 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4e6d60bbsm7856667a12.15.2025.02.11.07.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:24:09 -0800 (PST)
Date: Tue, 11 Feb 2025 16:24:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own
 thread/process
Message-ID: <gij5nh63s73dj5u33uvzl5lbmsvoh6zr5xnqpnfltwi6aamy7j@47iop2wgtdac>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s774j6juqpksx26a"
Content-Disposition: inline
In-Reply-To: <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>


--s774j6juqpksx26a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own
 thread/process
MIME-Version: 1.0

On Thu, Jan 30, 2025 at 08:40:26PM +0000, Lorenzo Stoakes <lorenzo.stoakes@=
oracle.com> wrote:
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/uapi/linux/pidfd.h |  24 +++++++++
>  kernel/pid.c               |  24 +++++++--
>  kernel/signal.c            | 106 ++++++++++++++++++++++---------------
>  3 files changed, 107 insertions(+), 47 deletions(-)

Practical idea, thanks.

> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> + * To cut the Gideon knot, for internal kernel usage, we refer to

A nit
https://en.wikipedia.org/wiki/Gordian_Knot

(if still applicable)

Michal

--s774j6juqpksx26a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6trlAAKCRAt3Wney77B
SacWAPwM6cjj3sPJP6MuZliNrQSB1iRXPL96jf7fhryBBezaDgEAzpQV4pbefEW3
T3w/EV38bXlaUQpqVL+5QFF3BmA2uwg=
=WNsn
-----END PGP SIGNATURE-----

--s774j6juqpksx26a--

