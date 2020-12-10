Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D732D67D1
	for <lists+linux-api@lfdr.de>; Thu, 10 Dec 2020 20:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbgLJT7b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Dec 2020 14:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390146AbgLJT7T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Dec 2020 14:59:19 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48804C0613D6;
        Thu, 10 Dec 2020 11:58:38 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id o17so7094735lfg.4;
        Thu, 10 Dec 2020 11:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GC/XblOlRvC+qjSKhqvPWSHVmyf1S0klyHzoOlN2iQc=;
        b=B5RF+oI/aEJk5oFliIENmOnUpk914JFiTNv0xNVgQe+zFhST94+JU5cbGP7hvBpD9v
         grxe8oo1mX5tiYCWySi3nscdMci1ElaO8JweSiONVZk+k+nFZ+Kil9YPERX7lJIBwAp8
         iy82acrzkeA+z40q3fstbj9Na9DxCUJBIJO4V8acsMMpNsuHaaCjX/6RpStSTLkStSlp
         +wdaFCm1yjv/7n6d1uFK+yR9yzHEX3YPRZ3gE15T5vJKAoG0OHqFg4VUTXpMMDBpPYFN
         litjpTzzUYBMug4zvP+YywyKEC/jnyuvyath1r6HNbRBTF3VG3syPj8iBwdgEZbiHgk+
         rlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GC/XblOlRvC+qjSKhqvPWSHVmyf1S0klyHzoOlN2iQc=;
        b=t57opLBFFhpW9+EIFUOhjeCTe51ke4emR+JSWaNOSXjdhIZaIThjAkXoSbC6niEuls
         9XSCbTnehFx9igE06uSvzd1tdl8FIjFLRc0AnUJ5+MDltH8u1/qcEy+DS3t3kk76zDR4
         ostvuH1++0gZfi7bYo5VzUWAzejo3CAsbFIKJuvqdrQBvzw/9dhDwXKHcle1Kt7oW54A
         viNJapX6Z+TmpsJPi3f9uH4D5a29hD7oLVs5cEiNbYhIROU7Jq5deqixa/9iSaWNj1+9
         4S1q5IkvAaZIECwc7HvaaPXGhzqNNe/rA/rd6RN7auDYrb0es/uFOTxHVkvKrE+Jt98I
         7YpA==
X-Gm-Message-State: AOAM532oiAvAjCtuPw06mvXdv2NSdtmszajK2TsNe0N0oTzgAFmJGCCh
        4n+vhXHKLAf059DGiBQpjv0=
X-Google-Smtp-Source: ABdhPJxhUF+Yv2avD1Pj5n+dOKXAWNePLfrPOFYOF7WHhPIbi9+WEBCX4vmjJXJECzcEC8KHTOt0Jw==
X-Received: by 2002:a19:8b55:: with SMTP id n82mr3398587lfd.485.1607630316854;
        Thu, 10 Dec 2020 11:58:36 -0800 (PST)
Received: from [192.168.1.33] (88-114-222-21.elisa-laajakaista.fi. [88.114.222.21])
        by smtp.gmail.com with ESMTPSA id r16sm712488ljj.52.2020.12.10.11.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 11:58:36 -0800 (PST)
Subject: Re: [PATCH] mm/vmalloc: randomize vmalloc() allocations
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20201201214547.9721-1-toiwoton@gmail.com>
 <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
 <20201203065801.GH751215@kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <37787c16-e188-89ae-a5fb-583fd97e6661@gmail.com>
Date:   Thu, 10 Dec 2020 21:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201203065801.GH751215@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3.12.2020 8.58, Mike Rapoport wrote:
> On Wed, Dec 02, 2020 at 08:49:06PM +0200, Topi Miettinen wrote:
>> On 1.12.2020 23.45, Topi Miettinen wrote:
>>> Memory mappings inside kernel allocated with vmalloc() are in
>>> predictable order and packed tightly toward the low addresses. With
>>> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
>>> used randomly to make the allocations less predictable and harder to
>>> guess for attackers.
>>>
>>
>> This also seems to randomize module addresses. I was going to check that
>> next, so nice surprise!
> 
> Heh, that's because module_alloc() uses vmalloc() in that way or another :)

I got a bit further with really using vmalloc with 
[VMALLOC_START..VMALLOC_END] for modules, but then inserting a module 
fails because of the relocations:
[    9.202856] module: overflow in relocation type 11 val ffffe1950e27f080

Type 11 is R_X86_64_32S expecting a 32 bits signed offset, so the loader 
obviously can't fit the relocation from the highest 2GB to somewhere 32 
TB lower.

The problem seems to be that the modules aren't really built as 
position-independent shared objects with -fPIE/-fPIC, but instead 
there's explicit -fno-PIE. I guess the modules also shouldn't use 
-mcmodel=kernel. Though tweaking the flags shows that some combinations 
aren't well supported (like ’-mindirect-branch=thunk-extern’ and 
‘-mcmodel=large’ are not compatible) and the handwritten assembly code 
also assumes 32 bit offsets.

A different approach could be to make the entire kernel relocatable to 
lower addresses and then the modules could stay close nearby. I guess 
the asm files aren't written with position independence in mind either.

But it seems that I'm finding and breaking lots of assumptions built in 
to the system. What's the experts' opinion, is full module/kernel 
randomization ever going to fly?

-Topi
