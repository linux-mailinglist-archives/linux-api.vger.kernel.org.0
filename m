Return-Path: <linux-api+bounces-2108-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A494707C
	for <lists+linux-api@lfdr.de>; Sun,  4 Aug 2024 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB71B1C20618
	for <lists+linux-api@lfdr.de>; Sun,  4 Aug 2024 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BE7347B;
	Sun,  4 Aug 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LVCT0rjJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094576FB9
	for <linux-api@vger.kernel.org>; Sun,  4 Aug 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804072; cv=none; b=MoyLHBzgiJykcQOWS+oNXZaBeeS4k3HHeZJEDBnGeEwE+v6+8qYQ2/St/9Zhq7x8sLYhuBw01Qo8xxs8yV1zSAhvfwv0FmGFkxv2tU8JkuETeLjCzaHtxaaRYKAvhBRFDFVmXrFCrtSBXsy4W+PrZ9K1KRTsL+40aP4SvN7122g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804072; c=relaxed/simple;
	bh=AZliAsMy1KQ0MTCOfVVvKYar8vTnwBzGjMoUW1Wh39k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1iyaZjJZ4lBapv0mJ/41G18tu6yQz3ZMaqWsRNarEAVaV7u7G85zOwyRfq6TdfB1huSfOSP38hhW/XrCLvY/XQCqOTeyV8lbEdTROzNlY3ZOUAhZx4sIHQNPAZcy3HmCdIFZBye4QAYAGkfAtIFBNZmOQpaTwniLy5zMzCDfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LVCT0rjJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so8526184a12.0
        for <linux-api@vger.kernel.org>; Sun, 04 Aug 2024 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722804068; x=1723408868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LJPoUhGsSbI3MesTWfLPEQy046rL3cbhs+jom/8YIqc=;
        b=LVCT0rjJl/NZW6Y6FGNFDeS0jbB4iVRPIMFa0fx5xdoTtKh88sSDz+ecfmVOl8iR7f
         aMUw+v5rQGxIfOowqpAJjcvMOi21yScfyW8YEZmHL2/C5ckTrk7K0z4UtNJbRCXAoLIJ
         nGJC0PzpODxXjRST2TKTvkkv3jnrarRdBp09Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722804068; x=1723408868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJPoUhGsSbI3MesTWfLPEQy046rL3cbhs+jom/8YIqc=;
        b=VSQwi0x7Qgf6T+Mwh+cRjHiBBv8C6vIig6NC3sZZ+yxWnfNsryRJTEEVsUV5IeaQa5
         xb4ecdFV6Dcd7NaS/ODwe/CT6qQtkrK3tYg1J/UnNmHLDvLcKXD7cOk2AOvSNmUmkI2M
         mALZ3q5JQnj9cAULIW7Z4PKgWaSzNa3MUDOMBLQeuBNuKg/IRGFz3Hbs1s64XsHcWSIL
         kjdfg8Mec2g0nvlC7/GEz+6dAagOeZ+juA4j65aEo7GttHDBeBSKKh0S190gnI1ajxuK
         DbspvFeakUVI8pg1VAZ7OAoWvSTtvnWqCdQW+H6TbIN3rMv1LWqvs2620eTRyLw596uJ
         AkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcV/YQU8vOkCbfXgk1Yl0Zgcvb/1QxMxdmiz/MAHyZN9/5MAW4q3ZcymPwrN7HxWs2qpL2Rds8frvbN9yCfohhTuHW1HUOBohV
X-Gm-Message-State: AOJu0YyzLbH1oVTt/xQjKcAYtQj6Ji5RLC4aLgXsEOoRbfP5zgK57RPT
	spY1WhnJ1OugSIAQKsMj9uDk5Z7d+4adEMJiSbOn4MhjitKxbkhXfg3fZml2dfJg5caILtZ0DF4
	oY/7hRQ==
X-Google-Smtp-Source: AGHT+IFgNChFaVcpXyN1nQBqE9IVFtImbdaSKw4ro6VJLOp5u557TBoUEvFTG1yLcOqFQLHPbFI1VQ==
X-Received: by 2002:a17:907:72d4:b0:a7a:b18a:6c with SMTP id a640c23a62f3a-a7dbcc28507mr1027106266b.16.1722804068134;
        Sun, 04 Aug 2024 13:41:08 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4392bsm366668566b.108.2024.08.04.13.41.07
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 13:41:07 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ab76558a9so802355066b.1
        for <linux-api@vger.kernel.org>; Sun, 04 Aug 2024 13:41:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHNL/ZMB08TZ4GmFILHC9wGGbpFg7jVN7xDXu7T1XyjBZNCEt3RUfYjpWndvX1N9VZ/MtA6TRoJPsur10Z5VX4zv1FNkZM0/oJ
X-Received: by 2002:a17:907:608c:b0:a7a:1c7b:dc17 with SMTP id
 a640c23a62f3a-a7dbe63440dmr975332366b.22.1722803580241; Sun, 04 Aug 2024
 13:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com>
In-Reply-To: <202408041602.caa0372-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Aug 2024 13:32:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
Message-ID: <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 01:59, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a -4.4% regression of stress-ng.pagemove.page_remaps_per_sec on
> commit 8be7258aad44 ("mseal: add mseal syscall")

Ok, it's basically just the vma walk in can_modify_mm():

>       1.06            +0.1        1.18        perf-profile.self.cycles-pp.mas_next_slot
>       1.50            +0.5        1.97        perf-profile.self.cycles-pp.mas_find
>       0.00            +1.4        1.35        perf-profile.self.cycles-pp.can_modify_mm
>       3.13            +2.0        5.13        perf-profile.self.cycles-pp.mas_walk

and looks like it's two different pathways. We have __do_sys_mremap ->
mremap_to -> do_munmap -> do_vmi_munmap -> can_modify_mm for the
destination mapping, but we also have mremap_to() calling
can_modify_mm() directly for the source mapping.

And then do_vmi_munmap() will do it's *own* vma_find() after having
done arch_unmap().

And do_munmap() will obviously do its own vma lookup as part of
calling vma_to_resize().

So it looks like a large portion of this regression is because the
mseal addition just ends up walking the vma list way too much.

              Linus

