Return-Path: <linux-api+bounces-2118-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E4A948293
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 21:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F29B221AA
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582C16B396;
	Mon,  5 Aug 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eQ5DPgcZ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8815ECED
	for <linux-api@vger.kernel.org>; Mon,  5 Aug 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887304; cv=none; b=mCjXh1cDO4tcTeLu7ZDx9tFTrAHr/zWq2FX9cDVoc2FZpK4f+mLPhuBPKCqAmKakcnqVMovs14+tmqaMReIYyzDWHlov2ckSvcYzjHoiCBqieGA9Sqf8BGJXR7LDyMwt4r0UJ5L2qJBeq810mvwMN3s7Adf5X86K3PeLkcokR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887304; c=relaxed/simple;
	bh=mgZkO49kXrbYPJTqfPbU/zGoDP6KaGhqgEz+BOKxzbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/KUtPEv7Bo+kS+XKcnAcMZzfi5FnH/bg+RawjMA6O/mxL+YVQ/DACIl/bxx6DCdDMOkaFWYFgeH6wM6382ozBY1KwxafY7taiebGsnL6xIhlcoReWqX6vzlHJ6IC1UERG/htNHNGUFk6b0Hk9X5RmtdmwE2EtyMX9eAz2L9998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eQ5DPgcZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso1232702366b.0
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722887301; x=1723492101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wlI56xvrJ7x2cg4LdNK/30BBgdmdk2xf+663DeBt1mg=;
        b=eQ5DPgcZhUKABCv0ZH3XhZcG1qgJC/Xvq1psSOISkehVLv62xCdWdZ/vFvUTDI+Yed
         mt9e1jZTmgjm4k57o2JY1E5V2rFQlBvgV7JvbDeYo0y9Z10RBdOLeXtKt2hR5W9qMkA8
         +B2BVZ9E833akp04bSZ6lDYSJJlg4onxlFHos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887301; x=1723492101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlI56xvrJ7x2cg4LdNK/30BBgdmdk2xf+663DeBt1mg=;
        b=i5TOTyp6xmPd2AEIScZhVSJ9l+ii7N2QU9Ns0WYaQViigACY3vHkIJn+V578TwJHaQ
         1rhy2jdFG0DKpcELwjaGwuKq99Wxx9Owzd7AAbNipkHoT2BfuV/U61nz8lpVinCbayXd
         wnQ6NXJEKKol+AMYF7TyCUIQA3PZMJKMFWT33EBKUu1VIsoxVfvX9+fqwke0CFKLr3YD
         OVGPPCfWRsJj0hrvwknSARGM0QsuEOx8Lfij31Hsd0JPlVV60gx2MLlB+N1nR1JrbLob
         MfFLGXobkbi0a+dWmQPEAUURS8YiyPGYyq6D5CA8mr4jN/vu90DkL4qgpxh4pARz940+
         Si2g==
X-Forwarded-Encrypted: i=1; AJvYcCVy2cZRYj1S4K0ZzJ0/wMq/MYI5WTWNkqj6A9pjx8oZ7rFbGKaPbocvGO+KbndKB0T50aiGRUG8pMZWCElqq2e1l9xlHFz/sV9J
X-Gm-Message-State: AOJu0YwF/ASTi2RBM+TRTeYxmToNBKPIq5dYelKRSjh4sciw2Us10Cid
	2CFp6UL7IMfpvw9qnGTPQ6Eg4K0JrMXyk61HsOi3l0Jd0kTPVXLGouwpd2uwHjitcfo1Jt8pTsT
	KG0XJNg==
X-Google-Smtp-Source: AGHT+IHDdffz1ibmFYhjJ25chqe+RIfbJ6K3EH4Re8fqG/nuYEfCFw71GWbavMVlgHJr2/4wkpOEqQ==
X-Received: by 2002:a17:906:ee85:b0:a7d:2f42:db54 with SMTP id a640c23a62f3a-a7dc50ff238mr931757966b.65.1722887301014;
        Mon, 05 Aug 2024 12:48:21 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dd074ec36sm452445166b.57.2024.08.05.12.48.20
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:48:20 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so1344026566b.3
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 12:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzjRMmKmjG85DwRKUD+THaIZVhhx86Sd9RlGZp5LUz7IDkMeNyVwJBbMZ/BwZE5GLbZYFXeVXJpK6ysjhqmi6shRQXnGbe5NdO
X-Received: by 2002:a17:907:3f8b:b0:a7a:9954:1fc1 with SMTP id
 a640c23a62f3a-a7dc4ea981cmr878526366b.24.1722887300410; Mon, 05 Aug 2024
 12:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com> <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
In-Reply-To: <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 12:48:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
Message-ID: <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Jeff Xu <jeffxu@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
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

On Mon, 5 Aug 2024 at 12:38, Jeff Xu <jeffxu@google.com> wrote:
>
> I'm curious, why does ppc need to unmap vdso ? ( other archs don't
> have unmap logic.)

I have no idea. There are comments about 'perf' getting confused about
mmap counts when 'context.vdso' isn't set up.

But x86 has the same context.vdso logic, and does *not* set the
pointer before installing the vma, for example. Also does not zero it
out on munmap(), although it does have the mremap logic.

For all I know it may all be entirely unnecessary, and could be
removed entirely.

          Linus

