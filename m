Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96006F5A0D
	for <lists+linux-api@lfdr.de>; Wed,  3 May 2023 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjECObi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 May 2023 10:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjECObi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 May 2023 10:31:38 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083BA1FF6
        for <linux-api@vger.kernel.org>; Wed,  3 May 2023 07:31:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74fb8677a36so244068885a.0
        for <linux-api@vger.kernel.org>; Wed, 03 May 2023 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683124296; x=1685716296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7llKhBaHnkQjLetPGzkZN0ajWGNkpSrzpK5vsJeUYo=;
        b=OEysCc3Q3AKZhYWUpecGGN+q2wOXE5wiyVvtko0WaJ2fEF5TgOdqBC+UgjJaKatM4j
         Hk8gD6ZHWvzvWGN6ZFM4ZdXXiLRZOENkqMpoEcR7TPHTjgYqm+JUUNaYF1NjPwNMH+XC
         t3AiZLBPIR/LbJUbtOA2ucWvWq1mgUvx6eYpoV8xcGmUnFf21ziYRfmryIfoB7XMQNKi
         Gep/JblJp11omSrcXBKcxDuoCpyJs5GbLr6596ivDXkas4ThRVy4RSYqyknHtPUU6oSb
         NRc/LfnhjI3vv4EB+X3g5MeSp0Hg72kS2vPM993Umv9YxSm+C9Nq9lQYrxlESiIsgBuu
         SP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124296; x=1685716296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7llKhBaHnkQjLetPGzkZN0ajWGNkpSrzpK5vsJeUYo=;
        b=CVDGMsyplRGUB0TxZlwxzRt12S0nTTVBNLH3vn0z+yj3O7BNRxwIsc0kN2Or/VUvMS
         WbAtelT2ceVrLgSuPs7FN4iDoW+1w/7QbNeODuvrYenA+KY99O94j5Kd8hhYl+2fS/bU
         SlQiNeajtu6GKIapF5eM894E6W/os9iTsgdI+7XcgDUka3Iy+MK9le8saYd6vbUI+ply
         ACUEBqUoMMAxjAOPCpvJaXjItUHRL3c2zGTW3d9a4IKyicQkwXbfPQtcU3FK57QFWeW6
         xEVcVaSnTk0rtPKpSGcMP8UOHvdO/tf3krxZMyeiUQPx345LNr3KkzJi5ff2rWheuk96
         WaEg==
X-Gm-Message-State: AC+VfDxel21WIh8l9ay9zRo+0lh95Yo0yPcOhUUsIgWudQZVDZhBmskp
        vAjgAggIUsvGkqLarLXZF1W7pg==
X-Google-Smtp-Source: ACHHUZ52pEaTCuzSpiKuoJ9hRntF1lpl/uhp/LT3ZTmSOW5jqLwz9JWE4c/5m2w391ttcRDRN6fT2w==
X-Received: by 2002:ac8:5e50:0:b0:3ea:8224:b5b4 with SMTP id i16-20020ac85e50000000b003ea8224b5b4mr504607qtx.9.1683124295905;
        Wed, 03 May 2023 07:31:35 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id d6-20020ac80606000000b003bf9f9f1844sm11116879qth.71.2023.05.03.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:31:35 -0700 (PDT)
Date:   Wed, 3 May 2023 10:31:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v13 1/3] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <20230503143134.GB193380@cmpxchg.org>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
 <20230503013608.2431726-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503013608.2431726-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 02, 2023 at 06:36:06PM -0700, Nhat Pham wrote:
> In preparation for computing recently evicted pages in cachestat,
> refactor workingset_refault and lru_gen_refault to expose a helper
> function that would test if an evicted page is recently evicted.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
