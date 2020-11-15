Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096DB2B3341
	for <lists+linux-api@lfdr.de>; Sun, 15 Nov 2020 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgKOJvO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 15 Nov 2020 04:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgKOJvN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Nov 2020 04:51:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D73C0613D1;
        Sun, 15 Nov 2020 01:51:12 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so20968612wml.2;
        Sun, 15 Nov 2020 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DxPhSq5x6juh7P8dcR2Yq3kUAwvxk05jpxUKEYJN6Sc=;
        b=aR8eavkPWhoWnzL/RN0tPKslk3HeE/9+6E7utMUn740eqL++lb6FHN9j8lxamTJqHJ
         Vje+KeKQ/igIFoOX+RJKWFKSTykRxgOiGKyg0mseiaMrxt8lec9rc9U+lm/HbcZpr8+Q
         RJqNLkvhUCiHP+5mc3Ap8weUzMvc01csN6Mud6Qu67Jca4M2U6Qzain/p/HzAhHSviKC
         lA4I4/xj3kfIYUFBCqUQi7zi0/EoRab4NbD8dXHruhjxDRNA85QyNJ7PZFLh2IRyA/39
         YUnTQQt/epGQYxALh3EoNMWAVS+AJ0cfgGAe8CRxv2AB7PfzZt5bP9I8YczABwblMEFw
         6ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DxPhSq5x6juh7P8dcR2Yq3kUAwvxk05jpxUKEYJN6Sc=;
        b=Q6uDb50sl8kve9g/WDCmwq3nbwNKStUKkN8kGCtRYot1BsBekgWqISH4KdHh6bcr1L
         qV7puwcgsV1q0763iMOQbgVUhSAbqRJ9YLPPQF+Crr7ugDZxVjpB0Hb/JdSszUn+e7pq
         PBei8VhaBabirzIDYlYFl/Y4vdcDLI9nhzZQlYKOFJ9c/JPIwo6zpn6ZcokLADCUxM4u
         a3DNT3ZPSbK38nLmltDf4T38ys6sfeciHZJt3H+laFu1514EUtv4uRFtOsP+ska6/5k5
         alBQRAQqXehzTQn5zKB8OW2KoOCYPE8Qj8H/hJWBrOd7hFvrHmLmw96y/7tEh2i5gvn4
         rL+Q==
X-Gm-Message-State: AOAM532h+GFOgQ45pu+53YaaCDuMLthw5sYwLDP6Hp8d6unRNQvT8htk
        gWCG0OD9c2aJttu38JrnPPM=
X-Google-Smtp-Source: ABdhPJy7JywbkquFwdP6gSZTViQiPHk5O9f8b+Tw4EP7CD5x/piMdcxCrmYwLDVKpyHCQfgWL40mjQ==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr10041707wme.23.1605433871086;
        Sun, 15 Nov 2020 01:51:11 -0800 (PST)
Received: from ?IPv6:2001:a61:24b3:de01:7310:e730:497d:ea6a? ([2001:a61:24b3:de01:7310:e730:497d:ea6a])
        by smtp.gmail.com with ESMTPSA id d2sm13217582wra.73.2020.11.15.01.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 01:51:10 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Dave.Martin@arm.com,
        James.Bottomley@hansenpartnership.com, andreyknvl@google.com,
        catalin.marinas@arm.com, david.spickett@linaro.org, deller@gmx.de,
        ebiederm@xmission.com, eugenis@google.com, kcc@google.com,
        kevin.brodsky@arm.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-man@vger.kernel.org,
        oleg@redhat.com, vincenzo.frascino@arm.com, will@kernel.org
Subject: Re: [PATCH] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
To:     Alejandro Colomar <alx.manpages@gmail.com>, pcc@google.com
References: <20201114014132.2439310-1-pcc@google.com>
 <20201114214914.177815-1-colomar.6.4.3@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <44cf5d5c-bd7d-1dab-40e3-0759201a9e34@gmail.com>
Date:   Sun, 15 Nov 2020 10:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201114214914.177815-1-colomar.6.4.3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Alex,

On 11/14/20 10:49 PM, Alejandro Colomar wrote:
> From: Peter Collingbourne <pcc@google.com>
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> [alx: srcfix + ffix]
> Cowritten-by: Alejandro Colomar <alx.manpages@gmail.com>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
> 
> Hi Michael,
> 
> as Peter noted, this patch is not ready
> (code hasn't been merged into the kernel yet).
> 
> And a spin-off question:
> How would you prefer it?:
> [
> .B SA_*
> ] (there are 79 similar cases in the pages [1])
> or
> [
> .BR SA_ *
> ] (there are 3 similar cases in the pages [2])

I think the second form has crept in by accident.
The first form is preferred.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
