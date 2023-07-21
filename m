Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4A75CA56
	for <lists+linux-api@lfdr.de>; Fri, 21 Jul 2023 16:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGUOnE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jul 2023 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjGUOmz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jul 2023 10:42:55 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC1935AB
        for <linux-api@vger.kernel.org>; Fri, 21 Jul 2023 07:42:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-78706966220so19453239f.1
        for <linux-api@vger.kernel.org>; Fri, 21 Jul 2023 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689950565; x=1690555365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdDHMIe9cztVUm68exPMuhOaghi2gznh0/5nfFVFao4=;
        b=Iw2r8lt3EXE/lGJI+Z+TgbWkqdCuKO2xgSx5o8bmML8JjgAavmXg1Gq6ZaHuWhxt45
         VvliDNpZgJr2cdlOGgYFDaW7zgv8FWGcMq9otkJWFVQp9pI7WQ0HyDNWopuSJLb6jxXw
         xpUVBg9uCjXXnH2nfZSMzTckgj36b70IRJf/qgnD5oFEZM3waIb36a7TrUulAzqKDre7
         g6pEvkKU3M6o2M2XsBg7fXhCD63lSsArv+5t9CwTRqSv/HHmGPQTPDpWQsDfFt5s57E/
         otFznxO9gm1N/9tGZ79U3SYpFrhoEHorvXTo3QPKtXwqwbEydF+2UHawVPZW+a69kW+p
         /STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950565; x=1690555365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdDHMIe9cztVUm68exPMuhOaghi2gznh0/5nfFVFao4=;
        b=Y17U22mo8sn8zQnYcZv3XfVbKEH9MOQVFZJnwppruiCSdNh1Ca+iGnrC10UjHH1xjs
         skMyDX9SLI8Jcp7tTdViaxhXYeqGq2NjjL/7ub3GLzProNB9oE8gSnxklZJAsSGDB1zU
         c7cniWIRcmdNz6Z4oFYSvpx+LVe+6S/VFAQMNdthTl+tdziWEylOF/PX2pomtW0i4VZY
         CE/gT7hAIkmADpdVLapLLGH/wOAw0RR+/lp3xtd4n+z37zkhJIH+r98X3zotx9WqwHRT
         uC3/BlUEXTvNgz8ZWgmeFdVQpoYAwEkNovGz+rOfth9OhnYZorYyvlVorFZ6HcJ2lYov
         Idrw==
X-Gm-Message-State: ABy/qLZyxZqcRTnR85+XUilSML/Fyw5HawfPPnLSQnhc6vTz3rsaXbSr
        UNaUImWjPDkoT4FrCx9x+FDokw==
X-Google-Smtp-Source: APBJJlEExOyixeH70jR2MtHJXYkNWk5o6Fv6eRLxjUzamtH1I6IPD96oIUz9hnM/aNDVt+3ptMz7rg==
X-Received: by 2002:a6b:b4d5:0:b0:788:2d78:813c with SMTP id d204-20020a6bb4d5000000b007882d78813cmr2070896iof.0.1689950565765;
        Fri, 21 Jul 2023 07:42:45 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d94cf000000b00786cf14a8absm1134207ior.43.2023.07.21.07.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:42:45 -0700 (PDT)
Message-ID: <8ab771e5-a8a7-8588-7877-76c9658afcd3@kernel.dk>
Date:   Fri, 21 Jul 2023 08:42:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 00/14] futex: More futex2 bits
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
References: <20230721102237.268073801@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230721102237.268073801@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/21/23 4:22?AM, Peter Zijlstra wrote:
> Hi,
> 
> New version of the futex2 patches. These are actually tested and appear to work
> as expected.
> 
> I'm hoping to get at least the first 3 patches merged such that Jens can base
> the io_uring futex patches on them.

First 4 now, as we'll need the validate patch as well!

-- 
Jens Axboe

