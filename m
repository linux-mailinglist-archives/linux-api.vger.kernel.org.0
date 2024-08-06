Return-Path: <linux-api+bounces-2129-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C8948763
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 04:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6648CB230EF
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 02:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6CAD5E;
	Tue,  6 Aug 2024 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Am8D4qac"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E16DF71
	for <linux-api@vger.kernel.org>; Tue,  6 Aug 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910646; cv=none; b=Nw9vmT9KZmEpB/1wl6P4OKflVlX4qbPGcF2NYe0OC8ufWLtpZ1eB59eQCmMrDc6aeZsZMmeCMgZqQYXu6Gog9A0nxXpmy9UbAAV6bYCCVj+yr5n7sxG5yZdQ1KaGQF+tXrqrtoPYxzB9TJ/mk6AYZ3kM4Opjm3RBNAnL932rbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910646; c=relaxed/simple;
	bh=1kbFbn/hAUhXKnkcqsPGGdbcnRxGgzs3MwJiZATRWDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orZaHDIkbGFugY9rQmUItVwscApPNDtVozWQYvyj2prwlLy2MDj+dghFOhWsJPBnvaidjDv/M4MZu3xrpEM9ubUxiV4bP4HJ3YRDuqmMpGwiEjhNAbiif/aAxKu7BNGG2gW/1IDEsnoEXtXt3Uwjd+K/qz+XQYJ5vcN1RIgphbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Am8D4qac; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef23d04541so1801911fa.2
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 19:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722910642; x=1723515442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwq5AxSs3t0w/fOZRG6eJ0P9hFWvane6MBazV/wxmCg=;
        b=Am8D4qacjeW9OrAKHivXQNmZMPg1xWa3COmbUhBur1GxBq0VDquvIk9ARMf9OK1X6m
         nemA6pxm+CxjRJosPHqj6qZ0/mHsubx3PaOR3OsclSZjC1Xr70FqaB/IZCP3QKIbPbUq
         rOdvDFcr/pTuV1sH0AhnHDCmHvrHhRBA8i7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910642; x=1723515442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dwq5AxSs3t0w/fOZRG6eJ0P9hFWvane6MBazV/wxmCg=;
        b=hDdKUnHFNj/PtEW6sp2Wbi437XMUIWEpaBLeCAKeuzd1iq/oTBn9ZRetP08bXampbJ
         XWiccTtJOD//FEVuRdJHhGtp8MS97jEtkIAYVtV6J59cEq6KhvO+IXDRZtCoJiesevn9
         1a5nlvizmH9+Jh9hzE/27Y1rHfEDkROuhCcvFk78ow2VuEVJTHqHDDvVylD/Hy3Hu/ES
         InOt82ksYUjxXACAiFb1e7n+1NuAMxKKof89GzU0/H2ukw+/64MuWwW6oRKjwT86RO5B
         vNGgFaxvkHGxfZ0/oidmssNsTOLconMARyCVS1xEeZm8/qatKvoDEIOj0s+y/Tc/VFbq
         I6jg==
X-Forwarded-Encrypted: i=1; AJvYcCWzGcJCiV3TYkFsG2Hq6JwSnUabh3G4+KViMCjdOR0Y24H9DCxjlK7cGSXR7DXDUXQNjOSr3po0zoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7OU7fIRALciaC39zJzgLfGbggkZ7Eu+dM0bL5ydK3jo6ZcUS
	REcXNIP7wwMZZqWLfgJmejck/r4u9lPXTL10Fqqxct0aYDpiEffbz0+Cs7THoA5G1FXFR+9n2Eu
	4C9ZfOA==
X-Google-Smtp-Source: AGHT+IGrPAEE22ZFFWVnukvGKMXlhmlX7pESpTtVfWh1S/+u4bNk/AoDV55Hs5UEk0vwYiXq2PX8aw==
X-Received: by 2002:a2e:8199:0:b0:2ef:2b05:2ab3 with SMTP id 38308e7fff4ca-2f15aa87000mr79665681fa.10.1722910642445;
        Mon, 05 Aug 2024 19:17:22 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb90be3a91sm1010065a12.65.2024.08.05.19.17.21
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 19:17:21 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so103495a12.3
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 19:17:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMm9yWgQCGqnucPLmdblMNeXjXmZ6tnjYTHyOn2UYxlpWDQM/PrAPRvBz/1ZMdD99Xv4FfXeFd+hw=@vger.kernel.org
X-Received: by 2002:a05:6402:a42:b0:5a2:cc1c:4cf0 with SMTP id
 4fb4d7f45d1cf-5b7f36f59ffmr9300778a12.7.1722910641236; Mon, 05 Aug 2024
 19:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com> <87o766iehy.fsf@mail.lhotse>
In-Reply-To: <87o766iehy.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 19:17:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
Message-ID: <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeff Xu <jeffxu@google.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 19:14, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Needs a slight tweak to compile, vvar_close() needs to return void.

Ack, shows just how untested it was.

> And should probably be renamed vdso_close().

.. and that was due to the initial confusion that I then fixed, but
didn't fix the naming.

So yes, those fixes look ObviouslyCorrect(tm).

           Linus

