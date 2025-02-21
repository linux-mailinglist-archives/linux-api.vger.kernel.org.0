Return-Path: <linux-api+bounces-3278-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A1BA3FD27
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2025 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C14818875F2
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2025 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978B24CEEB;
	Fri, 21 Feb 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyQLCDoF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7524CEDD
	for <linux-api@vger.kernel.org>; Fri, 21 Feb 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158072; cv=none; b=p5won+4CxD6cdSs3KhaDhdIMXprs36fXRvAYeM2tM+6Eh9vc8up8GcI0bSW84rjIH4BoF7Y4PoD6pxTDo+O3lbrTm6LoSEMHyhQP9ItHchaGKVDnoVLKOP6N4YUDu/wyWpvTmOPVJwJO6FTqScDVoVTrHpk6j2Epj0R/5xhiXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158072; c=relaxed/simple;
	bh=SQM2Zd24+tc9RM6wK1jpTq8xKmBYq+FC7GVRlyvHJjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUKInrzAimF/Zt7DdbKAGSTdIXDTjCXa2ud7AP0jOpbTG5og1gFzdKDzrofloERN00MrXXiKqGglZ/ATnZsewRZeRynNoWQGXYFXXCvhDYiFLegq/g/SVD/LFffk3lMQ2DYxixd94YUEDukEaR6ik7SUZhqBmAoXLtN2QaUTjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyQLCDoF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221ac1f849fso92135ad.1
        for <linux-api@vger.kernel.org>; Fri, 21 Feb 2025 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740158070; x=1740762870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0gSK2FCxaWmxefntBhNlF54L7D98cEEXS9T8Pg40TY=;
        b=CyQLCDoFa/zE6++mlqw9/KsI+uUGEGGE1NRLnxsbsEGAZC6RhYFjZXA3qJJcSpLmU7
         JghpZK4heJD18Z+PAHMtfB0E1Hri1POFz1uD05r2Gt3ounIcJ4zKvR7FLYrwONOXpWPY
         e2/h6bq6r8nOU9f0I7cjMlQnhUs8Y1X3RLPt2tV4Vaz58P3SaDfty1pa0mo47BoENgtE
         X1ynuZpOypslOQmy4zCIQghlOy2dEpKDWr8mEr1M2k4vPtbVw0IWbeIdtck2opYFcEc1
         ushJd9BtfkYwi8h+C+4PVsw/Lv5XumyEZoGilEY0LM8BazUAzT4+z7PHUbpexjUn/Ccm
         ge+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158070; x=1740762870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0gSK2FCxaWmxefntBhNlF54L7D98cEEXS9T8Pg40TY=;
        b=jOChfsT5GQzSbBTvUWbQSkBvg4u2Fac0WRnseU+Jq3vowZcj7B0todOVVQ3PWcPRPp
         AQQUAivbfBQym9WaBYbAXctu/+noCuGgJTpQx/rh0N+XvaB5Hly8lUGofzYCuLEZCZom
         FxvNv3YWBAkYT78Gitugw99Q6c/w3SIOHpqsoMpSSSzMsMhPcRPaII1eKrBBT7eipGsi
         U/znEh4vSRfP+s29y/Fh9G8sd4cWvq6uDZucGb4Bt4fFLVqNfbOavCIN0sT69d834AlE
         7S7ls/BbXE5dgsEHB2ydT+plSEnYDu9AGlTl5eaxsaqrZNreY9GBoDr8AQwcoFADuERO
         9hjA==
X-Forwarded-Encrypted: i=1; AJvYcCVu2WqXKIS3jWXD7skVCo1rPWiYfEIoGBWgT+Lq6cLv6b0mezaztgYor0KXwV8OxZvt6W8uAKwkxEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/hAW4YenG6vi9gqgBx7yZW4GS6LPQKfrdtxUM1C9TlFfb+K5
	7+qRvrORR6clyCGi5+a0pkEuMrZWwA4uM9w8clIjdeSTLy5zgt1cdYvav3srVbxeoDRxk/MnObZ
	3wbjCBl477pipEMSeA0/pzQQfggcdR+rvzH+w
X-Gm-Gg: ASbGncu9dl8N25CQr2k88cWYugJI+BlZK44AY5r4DTFWnkiExaYWGLAcv3azz08yGTq
	qfuEAjMLg7Y5K6QvOoLNPcjAX4dUYoNXuX3kw/r7I+FJ/NNBapSTIdYZjwL9Vft22MCChyingZ0
	y5GYJ8ICkKRJeCBcyOIptPmcEm/2YJ1r9PUqTQ6F0b
X-Google-Smtp-Source: AGHT+IFNyUGqlslXX37x4LbVQZRrq75tIiNhK2lhe/pPGYWt/2yXJVlCueghSa7c76ItC22g78yrCg/UqJB9sy8R4qo=
X-Received: by 2002:a17:903:2bcb:b0:21f:44eb:80f4 with SMTP id
 d9443c01a7336-221a045943dmr2994765ad.4.1740158070005; Fri, 21 Feb 2025
 09:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <164feb0a43ae72650e6b20c3910213f469566311.1740139449.git.lorenzo.stoakes@oracle.com>
 <32e83941-e6f5-42ee-9292-a44c16463cf1@lucifer.local>
In-Reply-To: <32e83941-e6f5-42ee-9292-a44c16463cf1@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 21 Feb 2025 09:14:18 -0800
X-Gm-Features: AWEUYZk3mhTNh_WBC5ffotM6wthK5i4atwZUkga3FHvQ0eq4dodOkvuYfjsE_F0
Message-ID: <CAC_TJvf8kqnAKAfHyTAz_c4-cGrjNYyLBUTWzYrJZGmanOvRGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/selftests: add guard region test for /proc/$pid/pagemap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, Juan Yescas <jyescas@google.com>, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Feb 21, 2025 at 12:05:23PM +0000, Lorenzo Stoakes wrote:
> > Add a test to the guard region self tests to assert that the
> > /proc/$pid/pagemap information now made availabile to the user correctl=
y
> > identifies and reports guard regions.
> >
> > As a part of this change, update vm_util.h to add the new bit (note the=
re
> > is no header file in the kernel where this is exposed, the user is expe=
cted
> > to provide their own mask) and utilise the helper functions there for
> > pagemap functionality.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

>
> Andrew - Apologies,
>
> I managed to not commit a change I quickly made before sending this out
> (I'm ill, seems it is having an impact...)
>
> If the series is ok would you mind tacking on this fix-patch? It's simply
> to rename a clumsily named define here.
>
> No functional changes...
>
> Thanks!
>
> ----8<----
> From 60be19e88b3bfe9a6ec459115f0027721c494b30 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Fri, 21 Feb 2025 13:45:48 +0000
> Subject: [PATCH] fixup define name
>
> Fix badly named define so it's consistent with the others.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/mm/guard-regions.c | 6 +++---
>  tools/testing/selftests/mm/vm_util.h       | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/s=
elftests/mm/guard-regions.c
> index 0c7183e8b661..280d1831bf73 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -2054,7 +2054,7 @@ TEST_F(guard_regions, pagemap)
>         for (i =3D 0; i < 10; i++) {
>                 char *ptr_p =3D &ptr[i * page_size];
>                 unsigned long entry =3D pagemap_get_entry(proc_fd, ptr_p)=
;
> -               unsigned long masked =3D entry & PM_GUARD_REGION_MASK;
> +               unsigned long masked =3D entry & PM_GUARD_REGION;
>
>                 ASSERT_EQ(masked, 0);
>         }
> @@ -2070,9 +2070,9 @@ TEST_F(guard_regions, pagemap)
>         for (i =3D 0; i < 10; i++) {
>                 char *ptr_p =3D &ptr[i * page_size];
>                 unsigned long entry =3D pagemap_get_entry(proc_fd, ptr_p)=
;
> -               unsigned long masked =3D entry & PM_GUARD_REGION_MASK;
> +               unsigned long masked =3D entry & PM_GUARD_REGION;
>
> -               ASSERT_EQ(masked, i % 2 =3D=3D 0 ? PM_GUARD_REGION_MASK :=
 0);
> +               ASSERT_EQ(masked, i % 2 =3D=3D 0 ? PM_GUARD_REGION : 0);
>         }
>
>         ASSERT_EQ(close(proc_fd), 0);
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index 73a11443b7f6..0e629586556b 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -10,7 +10,7 @@
>  #define PM_SOFT_DIRTY                 BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
>  #define PM_UFFD_WP                    BIT_ULL(57)
> -#define PM_GUARD_REGION_MASK          BIT_ULL(58)
> +#define PM_GUARD_REGION               BIT_ULL(58)
>  #define PM_FILE                       BIT_ULL(61)
>  #define PM_SWAP                       BIT_ULL(62)
>  #define PM_PRESENT                    BIT_ULL(63)
> --
> 2.48.1

