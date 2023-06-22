Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6E73AC66
	for <lists+linux-api@lfdr.de>; Fri, 23 Jun 2023 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFVWPv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jun 2023 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjFVWPu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jun 2023 18:15:50 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6DB2117
        for <linux-api@vger.kernel.org>; Thu, 22 Jun 2023 15:15:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3942c6584f0so5085999b6e.3
        for <linux-api@vger.kernel.org>; Thu, 22 Jun 2023 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687472148; x=1690064148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RWTgYq2UUxEsCsczZywS54H3UJIh7PEQ08XF3T1QNQI=;
        b=erEg5tOQrXPIIkPMrTVT0g485cXgkF/mSZwczNIMFvys3/3M8s5touTnozJgkJnrv8
         MFgmH40Daa20QkYuk/ODWSbN3LRXmOTp58f7zONk5K1txgIR2E8530LaoJ51BKnZY5aO
         q2mU71Au/pRMDG+NvsVvPFmQc6ZfVXk4ZJnNrQHF6MhxbN3POquh8W6sbg6BpsfU+l9Z
         TkwUKpPMpEYhD1uL94U3aeq6C4rVRimj2eXjJmERe1oophqJqKOGbPxQE61zl4rUBY/F
         iOzC66FM7hcAoKz+QXRHotEMNHJjsYwHuYiVdOFUNE5F6uu2fIgvAz22mSWoEyV6S/OC
         H5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687472148; x=1690064148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWTgYq2UUxEsCsczZywS54H3UJIh7PEQ08XF3T1QNQI=;
        b=AgYXxNDXo9v4uC1maTA5zuINJFJvvsMMwvwACNfYNiNS3BzcPFPnL1OdGaHAhPHO6E
         hLgcxPQoIE0w/ixcaKdlYLUY8/nuJHB9YqhDK5qgdnO8pxfKEDnWTHhURij5CgPzEvpk
         nBSv9qU1qmLmmZKnWDfXbkgQWiq4D7zFoMUjeAm+XxLHU/BmV4txAv2qxavamKYrh9EW
         6B//pJ5PshGaSZEu+DzkfaqVNE6TO62jFmpX4csKkYJZw3N5DEb2owEHd6C3164nKX8F
         CiAJvrr0U6UbgRuf9asiLRfX7FlUCMmz+7A9R8wXg6MrJvclsyJCFAYEnQBh6t+LMQhD
         LG7Q==
X-Gm-Message-State: AC+VfDzoAQWnVjel1VOTdFhQZgmjk4OSR7YiVuagEaBbNFzXslii8cL8
        lx38Qq0eY6i1q8Lk7wRpGGj3hA==
X-Google-Smtp-Source: ACHHUZ5xFMVs4yYQ56AKSUP4WsX6unDFAVwqpLuAsR4Evt1ihNZo7GTkH/lU8pygoBB2omszfgADtw==
X-Received: by 2002:a05:6808:1b0f:b0:39a:aafd:dda7 with SMTP id bx15-20020a0568081b0f00b0039aaafddda7mr22999807oib.35.1687472148243;
        Thu, 22 Jun 2023 15:15:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b0025b83c6227asm217949pjx.3.2023.06.22.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 15:15:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCSaf-00F0Us-05;
        Fri, 23 Jun 2023 08:15:45 +1000
Date:   Fri, 23 Jun 2023 08:15:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     stsp <stsp2@yandex.ru>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests: add OFD lock tests
Message-ID: <ZJTIEaqwkc1U050E@dread.disaster.area>
References: <20230621152214.2720319-1-stsp2@yandex.ru>
 <20230621152214.2720319-3-stsp2@yandex.ru>
 <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
 <7bbb29d2-4cae-48bd-1b97-9f4dbf6ffb19@yandex.ru>
 <8F45F47C-86C0-472E-B701-001A4FF90DBC@oracle.com>
 <26a798ae-b93b-2f68-71ed-35950240927d@yandex.ru>
 <187C3E49-A977-492E-99CB-97F032B24E5F@oracle.com>
 <4582a51d-2b29-f430-2f8f-ed1239d70f70@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4582a51d-2b29-f430-2f8f-ed1239d70f70@yandex.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 22, 2023 at 10:31:06PM +0500, stsp wrote:
> 
> 22.06.2023 22:12, Chuck Lever III пишет:
> > I don't have a strong preference. A good choice is to
> > push the test before the kernel changes are merged.
> It will fail though w/o kernel changes.
> So what exactly is the policy?

filesystem unit test functionality needs to be pushed into fstests
and/or ltp. The preference is the former, because just about every
filesystem developer and distro QA team is running this as part of
their every-day testing workflow.

fstests is written to probe whether the kernel supports a given
feature or not before testing it. It will _not_run() a test that
doesn't have the required kernel/fs/device support, and this is not
considered a test failure.

Yes, it means you have to also write the userspace feature probing
code, but that should be trivial to do because userspace already has
to be able to safely discover that this extension exists, right?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
