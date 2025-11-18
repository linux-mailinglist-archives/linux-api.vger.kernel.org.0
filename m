Return-Path: <linux-api+bounces-5346-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E60BC67137
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 03:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 264064E2E18
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 02:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FED328619;
	Tue, 18 Nov 2025 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S09RxRum"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42231324B2C
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434751; cv=none; b=uzrkRamShWtKhUawisSzg9T1MD5ytnPsIv2JYnVsDzCmhOdoXWBsmCCNhcQ0CvWlSDPpCKNEmKwxSmsDwl8Qt8o6FNXwxBjtmPW4UL8cmrzNyTIrJdDX9Qq2kWctIVnQXCLR2wqUtUTlQncBmelykd7MNEQ/FUsyqZoh7+slL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434751; c=relaxed/simple;
	bh=BUBQVqhYuDQpDKj8kaZMnE/33PjZCxGNIoQaBsNI2GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3xejM4gDQyTT2a8bPKh6KVSLDCQmhnnU5zB5EDF7dhJeOH8pqf/0VAEaok77MrwzMn7rbU5bXiK/qtDRamZnEJFkBFO/I9lRpzKa61kWXTidgVMAzikfuy8lM4F/yARhg8OahSVe8vnnNb4dd71PBt8Fb2YdHeDKVNP8tW3ygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S09RxRum; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7370698a8eso479080166b.0
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 18:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763434747; x=1764039547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uyA/z3+NX1r8lmPy90ZzbFhLB6Y/TGoAYT7nzfduTWI=;
        b=S09RxRum2xa9YUFARKFQLyZAIUb8pzrLmc5No4pxbFN+0VZWRe2eAA3w9TdG+UWb0I
         djrbsFgJmBy3SIxTG2f1dkRjT4C7HYeWKwBeSFma16HkIEuXNSzQ2hsS3kB17R2/GOqv
         p4m1geAB8IsA+7AMUClVb3R3Qg0pGN7Ba4V36qUTpdK0yJpkNitMFoyW5fINQUMXbMW9
         w3pN+WvtgyQkYLc8yarZpknb4hbDt466t4ChGD6/o7tk1pltNHmYjQoBL04Zxl9+Z/EX
         U4S56eyXw6C3jcvIfeZ8BBnmWW+2tzKj6u+vjIfXh+KP8c5FDQbyU5yyTuhJIwFcl4g5
         3MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434747; x=1764039547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyA/z3+NX1r8lmPy90ZzbFhLB6Y/TGoAYT7nzfduTWI=;
        b=vNiyRHpTcq647i8g7D1XekQofFvVqiuCXBRbj/i07o4HlbePelCOZ53KixQ6POjaND
         SMhuqccg96Y1v/Ky1HgXTWZY5Xn5pOIRHlO19As3QN/ULTMgN5ZY6gmTg03ttMjHuyud
         hfnz3YpmhSmX8tcU19EIxgSa6vSozy/9PWOPor0mCOKryFZ2u+gmb/20pWS89BPD1uRi
         97eavju2Mxp85tIkidzgJmz5kjuY91vJkaMi0TNOEC1qlYTMnHP9OGaQJVkHxehjldGL
         YfHvWCtIY2jouqBEKI4kn7h1RUC7pMs/vf0gxdaHRMz3ny6nR7QsPhDk4XsN0U0pg647
         zZrw==
X-Forwarded-Encrypted: i=1; AJvYcCWWWmV5TzdNEMMeo4v1Qp7ctFSrJaCKaLDxI+i4MWc2KbOvie1KST1fmeNVEmq9To9nHkfCFu63+sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82DMn9H28ggsak9RQk0hB/N6Qy+xK9i2mDb3pu0fBw0Yb9bUI
	MQtdRr140GyNUKGLRz/W6voEemoxMiXl9qvJ0IUgX9Bflm7j6DX8XxOUAEiua05e+qRAvUWx5T6
	Tm2+LfIFGkiHUWQ0QUDtswq5doQp89OMVjnxAxhkpTw==
X-Gm-Gg: ASbGnctldG5aW5OR+q/MbZiExCzpl3Zf4b6hsyK5UMi+CuHVr2bqXqMxrZPEcHJDhXP
	H853mc/OMJXsoQHajq44GKEEs9ktDJUOhst/HhyvfzxM6Z+3XUUX3KucoPSTMhrqbHn3hvwY0UM
	dTLpnRL6E5KWqZxxrVsBaW4TkFyqArOrc7+M7YHVA+ut2ylE+92pd6682GIQSYIXev7sFDruSjA
	1xRHLy/BucHNm6JsyR3HNPcAtDfC6dzyTQdGdR1whRYFns81DNn2zvFLb2L7alE8f9Fb8h285eO
	Q3E=
X-Google-Smtp-Source: AGHT+IE+Xmu/XKzqDItZxK55uKODQ4pXWe1jCDf3/zyE5l7HA0zpyHUAc1wH5fOIbLOq/qTekDcDuTCEd4KGgBq5NiA=
X-Received: by 2002:a17:907:d9e:b0:b73:9792:919b with SMTP id
 a640c23a62f3a-b739792959cmr714211466b.13.1763434747412; Mon, 17 Nov 2025
 18:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-8-pasha.tatashin@soleen.com> <aRoXGYC4GeAoNKPl@kernel.org>
In-Reply-To: <aRoXGYC4GeAoNKPl@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 21:58:31 -0500
X-Gm-Features: AWmQ_bmEx3-y1qL666uuCkHAOhqd8xREWBuFy8c9Q6i-THXVQGPt4k4Gmg9IHVA
Message-ID: <CA+CK2bDyKzeZBZvNM7OdSm5dBt3ADjsyXc2X3_YedV_xnphMww@mail.gmail.com>
Subject: Re: [PATCH v6 07/20] liveupdate: luo_session: Add ioctls for file preservation
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> >  static int luo_session_release(struct inode *inodep, struct file *filep)
> >  {
> >       struct luo_session *session = filep->private_data;
> >       struct luo_session_header *sh;
> > +     int err = 0;
> >
> >       /* If retrieved is set, it means this session is from incoming list */
> > -     if (session->retrieved)
> > +     if (session->retrieved) {
> >               sh = &luo_session_global.incoming;
> > -     else
> > +
> > +             err = luo_session_finish_one(session);
> > +             if (err) {
> > +                     pr_warn("Unable to finish session [%s] on release\n",
> > +                             session->name);
>
>                         return err;
>
> and then else can go away here and luo_session_remove() and
> luo_session_free() can be moved outside if (session->retrieved).

Done.

Thanks,
Pasha

