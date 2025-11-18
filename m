Return-Path: <linux-api+bounces-5374-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5FC6B740
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 20:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 995534E33BD
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E02D8DCF;
	Tue, 18 Nov 2025 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="am75plmu"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05919005E
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494321; cv=none; b=rXbSZQHz6Csa8x0xGLr5jBNXPGNcvkWaRZN/T7BsV88Bzi1/9ofT2jv3OCTKPC+h4kEW6UNrhVMpmTfdRSwTZSYotiQ4mtls+4pxhNIgpqqthvKc7l9YvT9AOKXPRajy3FmeLaxuGem7Frdhv36wDL+crR91hwOh8fDO+rRIiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494321; c=relaxed/simple;
	bh=RYaqzEIQYjC/AA8fKfHRWLmVY/sXnNn+7WATr1cqH64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoLSsQLvraOqZTEnotFnitqNmirT7TLAMCTgBXYXlsU+fGxsi5DDqBchhWOfUUiOCuQx6SByaqgLM06EMs8f13pDiMZQfPLuEoaBWuBKjGhYc+ZAidooaN5gJ5b1dUw0hhi162K7U6SHlWY6r/AuiypzecVHlWAnb1xwOCtXL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=am75plmu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b73875aa527so464017566b.3
        for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 11:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763494318; x=1764099118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYaqzEIQYjC/AA8fKfHRWLmVY/sXnNn+7WATr1cqH64=;
        b=am75plmuQWqaoMVVxSSFawR/0Enf59eLxMKJF2WuTzg1GxdIsi5MmiM2IrE3c/OjuV
         vArx+DVUex7GiWY1OVxM0lPbzNq2VGwxvGmqmJFDsrMOIfkPl8kkmwWAgwibkWaDJC8p
         yUr2haCUXDJxA2q4HzJTh+2BxiA1gMtdfD69Z1gDGuVBKmxYPzVJyTBUIoAVrCplahvN
         bgyCIyzAP3R/PVNSAfNm87kXmUk0yr8c1ykYHq67aQ0QpBCad+dR+h6nQWtfddHjdkwk
         tX/EOrlS9X8WRmfsSj++ykQmw9jHDYVe+3yIi7jQ0gLJraWR72L3gSaAmu54boixeJTr
         m1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763494318; x=1764099118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYaqzEIQYjC/AA8fKfHRWLmVY/sXnNn+7WATr1cqH64=;
        b=YJ9va1nxsE1hfc6U2aFKsDuxifumkPunMR9aidrej/0uLgxkM2HE7+Juf0MpqeclmE
         wHls3/CB/UQbaLhhV2rW/Pou3yk5/Pt8M+7quBd15LCCzFHflmtZS4a2N2BYi3vJO0Ps
         AeFOigud3PhFtZa5Es6z9pk6y728iZh7zCUhNfiXlSPfPc6AjylZe+Arv1VG11Qsnj8e
         sLswaS2QtPcultjR7G+5lEf8C5X1ICT9c/72pAtSGB1kMBRuhC14dgGPSMuVcNxV5kxj
         EQG2vOtRSYIzyq48aSpYsKQ0RZB5MWoRCInW7RQMKlfftPS1Q805thUaruvrHqawCPCr
         +wfw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4t8Oe6M+AcjXTgq2a25oWhkZMBnKau6pSC5iW8insFBtYLSZ5yXCxdlCnTucSMYOqgko86WstKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQRocxMIcZQ2iaXk8bC4VOq+9stOaO/lRA/M9BEFS0zhpRBiw
	JVGRLslTJJjRAo3Nbrt/C7MZnien6r+qa2yNIOpMfFxBTIeSGRDyiiiXOkuMkNqt+TRAB5lE0WL
	ZlUB2Zd1HDK70EZczWOUiDpfR4i47HQBYvizka+DVJw==
X-Gm-Gg: ASbGncsQoEk//CT3E/N4rpEUkx44312uXgllPbwkEnlz6UlUBZ6kG2LFn0OSZhh1LAP
	/Cp6rsYTzVhSTsZ94zJAKOVRktkc+r3Bp1pOKlKebQy7BfOttwVA9Crt969z58VqA4IWYvdAyqm
	kMidr9nLo9T4w5hOdJ9nJpVuB+4gA/mTH06mgDDO7qYDFE7fpakSXpQyz2ppm6iUrweNiH+k5An
	idNiT5ak3GWEVfWcV/SySPATw3/8vTrKLJSv90lXOT0MK0oTTyv7bxCPbGCdHlBwybs7ytH3F6F
	xhE=
X-Google-Smtp-Source: AGHT+IEoY5GxNNnNMoAylXF6Jyy2pRfpo8iGqzyCOOpRdKPPNoDFYT4pwtFBZN3XqQWL9L3hx4nbDu6IprbOG+APsaM=
X-Received: by 2002:a17:907:7b83:b0:b73:54b6:f892 with SMTP id
 a640c23a62f3a-b73677edcbfmr1719343266b.4.1763494318109; Tue, 18 Nov 2025
 11:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com> <aRyvG308oNRVzuN7@google.com>
 <mafs05xb744pb.fsf@kernel.org> <CA+CK2bAqisSdZ7gSBd7=hGd1VbLHX5WXfBazR=rO8BOVCRx3pg@mail.gmail.com>
 <20251118190901.GS10864@nvidia.com>
In-Reply-To: <20251118190901.GS10864@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 14:31:20 -0500
X-Gm-Features: AWmQ_bmbBbBA2popU7vHmJW9PAVFFPXLJPyntHOLQd2MbOo1GozNXCODJ9I9W2Y
Message-ID: <CA+CK2bBXRopZBBJi3YgN_PCwe2b98O=0oyu+XjUkfVrffrDVTw@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems callbacks
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, David Matlack <dmatlack@google.com>, jasonmiu@google.com, 
	graf@amazon.com, rppt@kernel.org, rientjes@google.com, corbet@lwn.net, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com, 
	hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:09=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Nov 18, 2025 at 12:58:20PM -0500, Pasha Tatashin wrote:
> > I actually had full unregister functionality in v4 and earlier, but I
> > dropped it from this series to minimize the footprint and get the core
> > infrastructure landed first.
>
> I don't think this will make sense, there are enough error paths we
> can't have registers without unregisters to unwind them.

I will add them back in LUOv7.

>
> Jason

