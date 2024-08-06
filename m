Return-Path: <linux-api+bounces-2134-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DE949387
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D22E288B83
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDEB1C37AA;
	Tue,  6 Aug 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c40VM2PM"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489C1BE875
	for <linux-api@vger.kernel.org>; Tue,  6 Aug 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955483; cv=none; b=ksACgDWyeGos5nECYWYS5cvsDItCgz2ONUXpZsj6Pn6Md3ifnSZ0PPmycQ+FJlt0gMdCrzZzsfVGCByyqycJ9objUk7HydkZonutFwDg8Scs5I7z7fooqLV5CT15HX5VISVA3in/IKvugLgMEr+wp2CTwc5wFZ/qIZqLXr9zXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955483; c=relaxed/simple;
	bh=2fP83v8ZDZ7pc5agamWj3NzXnt1SQztcQNzK097z7/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTmDn5FzXgKYEt0100hlLpYgVt4F7CWvwKTY6neeUIrR97c5KOfhAoMfQGl/q7JaZOkfKlrtNmlj4l7fPUF6rioYoSu2W97FCNbqupT5hpTrdB6VuA4ej7Qsl2Z/QY/tzJiB750clZDfYNbXkphC2z89yVSQLwfKD5sk3H62x3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c40VM2PM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so7772891fa.1
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2024 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722955480; x=1723560280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWWrNlqBqyxE+pa3MBe3r8meejGqG07YEY2OhAnz4Do=;
        b=c40VM2PMMJ78yiPgv8n+ShnOkVji7wU8T1yMdAIi+zQSQZA6KXcZcuExoRwoQlSdVH
         MmTjneM3ZUxM4UVUidflEaA8bdg3LPqWb3b4nMl9juA3WpMuOqy7H57LIFG9/MirsghL
         OayGWvrAI9Rqufxc5uINlM2kfsCy9X1B0ONAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955480; x=1723560280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWWrNlqBqyxE+pa3MBe3r8meejGqG07YEY2OhAnz4Do=;
        b=JbbpIZeTo/W4q1KK5H3fTxzzGKh+9BUBaSLlruDu/Zcgjo0gLxsx24WYK46xGS2Hea
         oW5RUr8bGhz9NnlNh0RhOc4PxEsYVRgiqGIZTC5xROi+ktGslXhAer1PJ7Hy09BeWzIL
         oeRu37qe8dm5pUJE6WvD6S64M1TFtZSpgbw7jQjHVky40VEIVOsePgz2l5VFCnriostJ
         nrKjsHvhm7xdCfKbmCoz+YAtCMEVsZQ2bsPFjI8hfRcfEcPRTgEqXCtAp3Z2BCeuZbDy
         /MMyQK1W/YCDGN38hukEArqz6WoBn6xqJX7vf4/eOgrEgrqjdaOdRWBSN5RW7gqEN79n
         MD7g==
X-Forwarded-Encrypted: i=1; AJvYcCXtAjQPCZ4OzyJZvpd8RUn2hTffWON3nm79zp5JVmhiDgvP+XnKuoj0r4g3g+KMP5qL7WTbIkNAtSZoZroXP0lIKYdNR2k0NN0H
X-Gm-Message-State: AOJu0YzBw140icLLtI78QI2Upro/a5o8Bdm1JfdC9+Ezr7sykgoK9es5
	Xwc7cDY5MTmCILUknyFyEgA0LqSGK/K/ZGiGxhpIhJYjZy6JqP7lDKPX44ncCEp8zfZM4m0FeP9
	fYYC77g==
X-Google-Smtp-Source: AGHT+IGH1OdLOfNEAVhr+N5hA0fTV6ujGHj1IDSce4jSJnZ+3Kame1J6JVQznD3Ou6/Y6pcTtGu58w==
X-Received: by 2002:ac2:4e0b:0:b0:52e:faf0:40c with SMTP id 2adb3069b0e04-530bb367688mr11243931e87.3.1722955479472;
        Tue, 06 Aug 2024 07:44:39 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b931794sm5997234a12.64.2024.08.06.07.44.39
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:44:39 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so1105003a12.0
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2024 07:44:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEcunoZCA8xLMTp2RN+41GlZQGIxl/YXkShooYxPjbGndFVDlyE1zP/g23ZUmJ7b/es7zpIfWSpsO5VfUet0XUmlzZz+n5swpc
X-Received: by 2002:a05:6402:22b2:b0:5b8:1035:214 with SMTP id
 4fb4d7f45d1cf-5b810350411mr8834214a12.33.1722955106581; Tue, 06 Aug 2024
 07:38:26 -0700 (PDT)
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
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com> <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
In-Reply-To: <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 07:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+rSKmNvFBpaKW+Hcn8YSzd2az2Lp5ii7Q4_o0PepJ_A@mail.gmail.com>
Message-ID: <CAHk-=wi+rSKmNvFBpaKW+Hcn8YSzd2az2Lp5ii7Q4_o0PepJ_A@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jeff Xu <jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
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

On Mon, 5 Aug 2024 at 23:05, Oliver Sang <oliver.sang@intel.com> wrote:
>
> > New version - still untested, but now I've read through it one more
> > time - attached.
>
> we tested this version by applying it directly upon 8be7258aad,  but seems it
> have little impact to performance. still similar regression if comparing to
> ff388fe5c4.

Note that that patch (and Michael's fixes for ppc on top) in itself
doesn't fix any performance issue.

But getting rid of arch_unmap() means that now the can_modify_mm() in
do_vmi_munmap() is right above the "vma_find()" (and can in fact be
moved below it and into do_vmi_align_munmap), and that means that at
least the unmap paths don't need the vma lookup of can_modify_mm() at
all, because they've done their own.

IOW, the "arch_unmap()" removal was purely preparatory and did nothing
on its own, it's only preparatory to get rid of some of the
can_modify_mm() costs.

The call to can_modify_mm() in mremap_to() is a bit harder to get rid
of. Unless we just say "mremap will unmap the destination even if the
mremap source is sealed".

            Linus

