Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4875E4C6E6A
	for <lists+linux-api@lfdr.de>; Mon, 28 Feb 2022 14:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiB1NlZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Feb 2022 08:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiB1NlZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Feb 2022 08:41:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500ED7C7BF
        for <linux-api@vger.kernel.org>; Mon, 28 Feb 2022 05:40:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so14789141pjb.5
        for <linux-api@vger.kernel.org>; Mon, 28 Feb 2022 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=8AEAKRGq8N0ON2WXDBrR6DvzDs8wlyStSGQdnh6J7Bk=;
        b=4CGakBFMfUd91qW2Zea8Ay3ZXjgwkHfjpcl9oYfHzNaGzNy9R9r4qRkFRFSMGvdimo
         d9aOWeUry/nhwT9eUXWJ1Vq8+4yc3w7X6NAuRXJjoROQ7c/8yWVNI+d3DhywL3wrpXAx
         32iNRwgY85RS27y4NP7pvSzs09tLKp4y2lWzVSVRMGR1ee9agNNEKlLQSLHgXAiD/KGa
         ImzsQlTnd5LWZmoyQjG/sO6K1IwfA3qXlaxtn6GQvDtaMXf+X8T6a8lhnwP5cCVECV9u
         v/M/BeiRS7oDi9lLiRXD0lptuZtCWieGIRQ+JHh9uUhcZelgoB1r6XH1l02MbpWdWG3Q
         a02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=8AEAKRGq8N0ON2WXDBrR6DvzDs8wlyStSGQdnh6J7Bk=;
        b=qCzeqtw9V9bTeiO4HXtRMqgMDX3kopxydMVcHRyGlJWefF3BapfxZvImCiwHZGHrbe
         /M7+tcfY7GIZCi5f84MVNPTHUf3BiVY/hs+EIJX7Htw4omQsHg60ZhT7tRJVEPZNn884
         4McTFIyco4tLZw/wx614SRbcWHYjOtbymC7Us0EJY2dNJ4VuuPd7Khx1HqtnxhJ5LvJL
         jBBsMdYZA7eWmBa2wsl1rfc/KRdJA/z+TmaImqof/UDP1+Z6Nhw1aBPnV+3x5hQS+0WV
         VBFln3h8YGeNrUgPdlR31kbUTM+6KFBSOzxxWHNiwNfzjbAw6+TSG1gZqkJA/0u4kTdu
         F1MA==
X-Gm-Message-State: AOAM53144jORWy4S4Z6/+mwqXPj1tqH3lskzB5+jKrf0CXoOP7infkTV
        RYtXVUB2n7s9EHOj3q5a6qs+O1lQBQfWuQ==
X-Google-Smtp-Source: ABdhPJzDDppjzyaiKiUKTzeLYFsp1i6YXo3jAy8eqnS0f2r8SktthNeZeMeNsqYu6qmmYNsunIPtJA==
X-Received: by 2002:a17:90a:578f:b0:1b9:b03f:c33c with SMTP id g15-20020a17090a578f00b001b9b03fc33cmr16854315pji.114.1646055645500;
        Mon, 28 Feb 2022 05:40:45 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s2-20020a056a001c4200b004f41e1196fasm1085316pfw.17.2022.02.28.05.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:40:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220124215938.2769-1-ebiggers@kernel.org>
References: <20220124215938.2769-1-ebiggers@kernel.org>
Subject: Re: [PATCH v4 0/3] block: show crypto capabilities in sysfs
Message-Id: <164605564421.5266.4770347755442851079.b4-ty@kernel.dk>
Date:   Mon, 28 Feb 2022 06:40:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 24 Jan 2022 13:59:35 -0800, Eric Biggers wrote:
> This series adds sysfs files that expose the inline encryption
> capabilities of request queues.
> 
> Patches 1 and 2 are some related cleanups for existing blk-sysfs code.
> Patch 3 is the real change; see there for more details.
> 
> This series applies to v5.17-rc1.
> 
> [...]

Applied, thanks!

[1/3] block: simplify calling convention of elv_unregister_queue()
      commit: f5ec592dd3bcf7c91f7c262a7f5011e001d269cd
[2/3] block: don't delete queue kobject before its children
      commit: 0f69288253e9fc7c495047720e523b9f1aba5712
[3/3] blk-crypto: show crypto capabilities in sysfs
      commit: 20f01f163203666010ee1560852590a0c0572726

Best regards,
-- 
Jens Axboe


