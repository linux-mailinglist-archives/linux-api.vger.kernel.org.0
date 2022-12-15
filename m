Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F1664D7A1
	for <lists+linux-api@lfdr.de>; Thu, 15 Dec 2022 09:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLOITW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Dec 2022 03:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLOITQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Dec 2022 03:19:16 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0119014
        for <linux-api@vger.kernel.org>; Thu, 15 Dec 2022 00:19:15 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 192so2618876ybt.6
        for <linux-api@vger.kernel.org>; Thu, 15 Dec 2022 00:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=BCvpmkquQf7K5NYHgRMqHmttNIhEV60vdjFKBfjJ+1zRnZwQHIMf/u/nGftd6WVvCw
         Z0ciIMO8jz4AsbIZg6iCvNoPDqOxYNLIezU8jQ3m74Tbjhu9yw1XQjnJ2aD6LTAHXIXx
         Rf9HbH22NZJYhMY+GKVJz6nFG3tk31xj47r6X6QV4zodetcDENwCZmzRwPsUOntTBLDf
         pgS1kv+pR08DXIYdem+hvp29ti9ee8upKlKNt62Rt24BVEwIGoFtNVMZvExGl+vKT7Vi
         +ToRnC7JAd01NwcL59Zgt1n2XgLMoF8xOXz+Y160PNwiRm2Ir1VLtucx0a1t4PSriBtB
         rEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gfWdjP9nJhvOzhCYsXFdFkNEQ4J9IEXJ/A4Tp8HNNmNaNBjLDmXK9n8C4agC6Qyn0m
         gCVx5Nxlkjc9XuM8GN08DKeQiupWG/ILbM+RQ2XkIzEj9ndAO+ql1m4k61w7HejHq//F
         VQHIxyboCXUM5v5+2SUVu7vgrByVYwiPn+wuNUZBnq/2C7xrw963bGgQZXcMqH0GTuUm
         xmS5U6438kMd4xC4UVDwCmuDcVdXddU7uj8Qtce7fAIkxIK9r7+6/inoXJPmknyj5mHj
         U0XWVn+OzXzf+y2TVPDs6yDJMHWAdMb4RUTIPGrEvYkEPchZ21sWfRVOSzUV6RGZZcDW
         vfQA==
X-Gm-Message-State: ANoB5pnxKHU9BkGWTrseDChlZ8oFWNBwS2MV1HD6C9rlqyX9OaaU7f7c
        XMH0/rIbbGnwvXRzom7iH6jDF3KT1fmgxZf7nbA=
X-Google-Smtp-Source: AA0mqf4RZEju9zZBIqx73toNOu/WqT1MdleHvPC/cgo50ps+xqoBlOrj9vm7m94uNoRUtDr82g5fRh0t1ijQtop7ybI=
X-Received: by 2002:a05:6902:91b:b0:6dd:313b:9b30 with SMTP id
 bu27-20020a056902091b00b006dd313b9b30mr96640520ybb.618.1671092354182; Thu, 15
 Dec 2022 00:19:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:7292:b0:315:c58c:168f with HTTP; Thu, 15 Dec 2022
 00:19:13 -0800 (PST)
Reply-To: victoriandersonoffice@aol.com
From:   Victoria Anderson <kossisedo408@gmail.com>
Date:   Thu, 15 Dec 2022 00:19:13 -0800
Message-ID: <CACDcUwxAUeHR799M1z_STGh2WaaYfNg8_zbGRQCBKrN6=ZtaLA@mail.gmail.com>
Subject: Good morning, did you receive the first email i sent to you ?-
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kossisedo408[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kossisedo408[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


