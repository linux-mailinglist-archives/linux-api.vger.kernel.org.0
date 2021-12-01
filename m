Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF4464543
	for <lists+linux-api@lfdr.de>; Wed,  1 Dec 2021 04:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbhLADMo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Nov 2021 22:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346406AbhLADMo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Nov 2021 22:12:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33540C061574
        for <linux-api@vger.kernel.org>; Tue, 30 Nov 2021 19:09:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iq11so16865972pjb.3
        for <linux-api@vger.kernel.org>; Tue, 30 Nov 2021 19:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:reply-to:in-reply-to
         :content-transfer-encoding;
        bh=JCdsNFesDkuuM1VR2LPSkkTD1jlcMDvQK+ffmxURn+g=;
        b=bgbM3XhbJAWBjpnSaRSKN5x9K9qNIxiC7vK0MluFkyVxwWpjK7InPC7X8JgtyS639t
         VK4p76abakz/439mKRQ+KokCvszmbJUfuMmvAotKJPK/7IXCTlITTsqFMku+26CGhrJP
         O5pany0S58DGuTfKl/h+Pxsvi3F14Cu9qVKSA6X2GbSIwACHTW+weykLsjJFwDN724Rc
         aROBbBBkFWJ8fW5aFU7ubkDai+tcGRcmV2VwfFSKu4DJQtZ1A0g/p1YkxbF3KdJkKqWJ
         LbRBPIxpzbjhEPo5Y9yzKivcrMPBK7w3uiZvx2r4tl9WLbeRQxFkwoRnYga4zZ52xx0a
         tU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:reply-to:in-reply-to
         :content-transfer-encoding;
        bh=JCdsNFesDkuuM1VR2LPSkkTD1jlcMDvQK+ffmxURn+g=;
        b=HJOXROzjxCxPhsuqJDFMJ8lv5aA+wFI1GxvuBzj2wdZNFPHuzjDhRN+ofSFnMXay4h
         qpWDst5rJ5fFO8CoU7LqBJF/VWQsVQ3kXBdVYPUFp768gHdsLVpZkZYTeN2qXaHsl1+X
         CvSlttMjdjAr2GfKSA3nZZGInQ5L046ZPDh2vmDccKtbEn3SAdgDNRuREqiZWyR4eNo6
         qB9s7Rw2/1T65P/KckX4AZYi4X52dwqm75/KNK4n2JlYRsLmjMLIW4HNI2+bsfduoEkR
         xy6EinA62OSxZp+2eP18r35ccnYNlFs49abV5GxfKlxrpbsXGa9bJO/IngMPbPaCM5n+
         Wa1g==
X-Gm-Message-State: AOAM532Ipb9x/J6LBgShR1ylzQok2z8yyBfg8+ZrDnmu4bUnr2M8MjNo
        6lcIJRZp/Ei3KPZrwymNsjBmTQ==
X-Google-Smtp-Source: ABdhPJxiUGARIFqsFxUSlvAWP1A7uyuEjb9oPxtVgNSIB1NC1DI9nd/TbQZJc8nJEFO6CJEFgKtUhQ==
X-Received: by 2002:a17:903:110c:b0:143:9edf:4985 with SMTP id n12-20020a170903110c00b001439edf4985mr655597plh.15.1638328163791;
        Tue, 30 Nov 2021 19:09:23 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 16sm9637367pgu.93.2021.11.30.19.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 19:09:23 -0800 (PST)
Message-ID: <b0d1f682-6868-c5f6-631c-2da93ee2b479@bytedance.com>
Date:   Wed, 1 Dec 2021 11:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
To:     feng.tang@intel.com
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
Subject: Re: [PATCH v7 0/5] Introduce multi-preference mempolicy
Content-Language: en-US
From:   Gang Li <ligang.bdlg@bytedance.com>
Reply-To: 1627970362-61305-1-git-send-email-feng.tang@intel.com
In-Reply-To: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Feng:

I am a little confused:
We have `MPOL_PREFERRED`, why you introduce `MPOL_PREFERRED_MANY` 
instead of making `MPOL_PREFERRED` support multiple preferred nodes?

-- 
Thanks
Gang Li

