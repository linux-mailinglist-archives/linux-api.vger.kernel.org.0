Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58219F2EC8
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 14:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbfKGNDl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 08:03:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40031 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGNDl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 08:03:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so2171793ljg.7
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VVzEmQAwNCiO3UreRfk9O/Z8xmpQhuuKJsJFC04ETM=;
        b=DPXN83Fz7hWLCJ8SiEtAmuCTSVcmzh1ZSulcSUFgOty94RQPfaGfyvUYqzGTPR9El/
         retYbm85LjupLHjFbRsSQPcCjXaM6mMK2JWD5umssbS4JCgYFqpxHiv4kK81sqVtf29X
         vLZI6/8ptgsfNayLKqxJfrU9rOvWbSTNUhuu0/t9ht3rYZF4pqUkTBAWR/NydWdioDcB
         uetricmGIe70Ugr8niF55jEUpzkFPTDut4P0ERKLZOKDxZfEBKSF7M03EAcXvgykx+U4
         /3xODamg8RyZQtor+JxLQwDiYcKHXDqGgDvhdhbQekfDQy0aCqEtIqA7EFtlnZmmv0cp
         6qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VVzEmQAwNCiO3UreRfk9O/Z8xmpQhuuKJsJFC04ETM=;
        b=oJEQxdQzn25XeMfbunGJy31Otb0SU8PayKAt03L8fkls20B1jn/DC972RA0vES+2hN
         /3OLEcfyTVb8pVlQ4xGUNo1UJVwm1WTFBIpkb7UIFp3WEo6IztBKmq+cCUZLj0RxtAi7
         TG8raTLCXGuT3Xa5vZpIpkCQ2Fjv4xNtavWFSL/ZpOLjb2Rbtx04CIW7iJZa3j8x402e
         KUAGe5ui3OOasAOdE6QEqwTTm9vqlo21SpYxcvE73qc1UBFMZJI1G9JGva7rI4E7evl9
         tzscd9+rZpt1vEric4vmT7IoAsGeDYFqz/f8/v0uSmGcbUDbI1ZJSykj/7E3qd68nkVU
         ehCw==
X-Gm-Message-State: APjAAAVMGr5chZ1UllWOhjQx8dnzBJuSEC4smLF4/IqZdd8anlGej8GF
        P74/t6f47suY6B0pzKDrCjccxq5he68Gjp39QgM=
X-Google-Smtp-Source: APXvYqyZ6hga7XTpUXcIAYnQwMfOmYyR25HwdkZ9tn4goBGyybcoUM9mxoh5X8z1FtC4PIsQIj59NJlmBKfEzn8ZnU8=
X-Received: by 2002:a2e:2e03:: with SMTP id u3mr2474084lju.115.1573131819166;
 Thu, 07 Nov 2019 05:03:39 -0800 (PST)
MIME-Version: 1.0
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
 <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com> <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Thu, 7 Nov 2019 15:03:12 +0200
Message-ID: <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
Subject: Re: Continuing the UAPI split
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 7, 2019 at 2:10 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> The kernel uses some POSIX names with POSIX-incompatible definitions,
> e.g. struct msghdr.  Some libcs prioritize POSIX conformance over kernel
> conformance and implement userspace translation for mismatch types.
> When building against such libcs, it becomes difficult to use UAPI and
> libc headers in a single translation unit.  (It is already difficult
> today in some cases.)
>
> I don't know a good solution here.  Not using POSIX names in UAPI
> headers is one option.  Previously, we have tried to use preprocessor
> macros to coordinate definitions, but did not work well in practice
> (only few conflicts were ever resolved).  It does not help at all when
> the definitions are incompatible.
>
> Thanks,
> Florian
>

Thanks for the response,
I'm not sure what are you suggesting exactly.
A rename to the structs/types so they won't collide with libc?
Prioritizing POSIX conformance in the kernel(I think that ship has long sailed)?
Or just giving up and telling users they can't just directly include
both libc headers and kernel headers?
(I'm actually not sure how it works now. because there are definitely
collision and if we are using ifdefs and undefs black magic you still
end up with a single declaration in the end that might not be
compatible with both libc and kernel)

I'd personally really like to see a better separation between (g)libc
and the kernel. I

Thanks,
Elichai.

-- 
PGP: 5607C93B5F86650C
