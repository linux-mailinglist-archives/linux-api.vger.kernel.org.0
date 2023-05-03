Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A96F5AE3
	for <lists+linux-api@lfdr.de>; Wed,  3 May 2023 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjECPWl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 May 2023 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjECPWk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 May 2023 11:22:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D325580
        for <linux-api@vger.kernel.org>; Wed,  3 May 2023 08:22:38 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75178b082a5so135109385a.1
        for <linux-api@vger.kernel.org>; Wed, 03 May 2023 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683127357; x=1685719357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z72RIdKmaEAHhQSJvbUggUruDGfXxzyBpebhinUUrDk=;
        b=5re4CQifcjgd9jxTsVO9hmhw6XMxMZLnn+9npz6K1XjDCQ8FvkKJE3X6Yw4GkTPAGM
         FbvGtFkH/d+NJOWM3Q1x6nZoFb+jc+X8Taw5QBSs/hEhgEe+ZMp3MaxCwjyd40CQGqNw
         4BSbRR9FgKVb4EOoP1w+l1ybPqbF97tlvZuF4TaFYkQL/CYHpgxlM6rgsnGHDzYuMMh/
         p2+7dkbgEiMBIT2eGpcMqkT+SfAnDGxDaz8/+6M91ysZaSwycbmKeyYg6ZpkUy1Mg6Sw
         fcLO/8PJqzpX0w1KpblmJPgjHfSzQH/BAYHMESvYMfGj9F95/wfgCms82p8c6UwSNs3o
         0P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127357; x=1685719357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z72RIdKmaEAHhQSJvbUggUruDGfXxzyBpebhinUUrDk=;
        b=J+r+FWkgiIpERbMCc5h6m6LI6Di/svjdnLfMx78utjV5M97iIrlqCAChtSqJH720zG
         WW+aDuxdhVZV7tb6xrdmtTpt+OJ6+VI2rEtVHDzRjykH+bE/WxExaB9kQo+POX1hAzIa
         SQ41Vs8os5e1zdQqnt9JuCg9Ra4Aysw52Xvb7rhKOgDpZKeeAXyWL1RmFBxUMTXFRlXN
         9gUWlJoY9InqQ7LIJWu4Fyi0Nfy/ooxtLjIDrOIGKswUzCHCjLRKOe+U8KX500KVbhdc
         LVYrImbAFaLMzc7GiuVnQEzJNNCbInt1JZ2rfUtlqUBibCfTyV9qeC8fG69hE9k4ty+p
         NgYA==
X-Gm-Message-State: AC+VfDxcfak2gykDMMDPvLtKInHIkIL9m3SaNCNhi2npb3oLxSPeiTAq
        yg5zdZhScsj2utcTm0cGgkcQHQ==
X-Google-Smtp-Source: ACHHUZ6fGMSFqnaJplKEuCgOeeUB553kYejp5VFW8TunnY7roEmjKtyUeC1wrv92nnbOwFt/+39Z3w==
X-Received: by 2002:ad4:5ba6:0:b0:5b9:3f17:b219 with SMTP id 6-20020ad45ba6000000b005b93f17b219mr9586749qvq.3.1683127357643;
        Wed, 03 May 2023 08:22:37 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a444800b0074e026a6a43sm10732751qkp.9.2023.05.03.08.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:22:37 -0700 (PDT)
Date:   Wed, 3 May 2023 11:22:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v13 3/3] selftests: Add selftests for cachestat
Message-ID: <20230503152236.GD193380@cmpxchg.org>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
 <20230503013608.2431726-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503013608.2431726-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 02, 2023 at 06:36:08PM -0700, Nhat Pham wrote:
> Test cachestat on a newly created file, /dev/ files, and /proc/ files.
> Also test on a shmem file (which can also be tested with huge pages
> since tmpfs supports huge pages).
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

*and a directory

Looks good to me. It covers a good set of real cases and weird cases.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
