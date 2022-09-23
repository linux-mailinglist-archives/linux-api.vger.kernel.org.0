Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAC5E73A7
	for <lists+linux-api@lfdr.de>; Fri, 23 Sep 2022 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIWGFR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Sep 2022 02:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIWGFQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Sep 2022 02:05:16 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F5286E3
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 23:05:15 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e81so15736994ybb.13
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 23:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=xqV0SEJtZbR/dGKSwq8YnqP6PVCCHS5FOV4KkHOfuyU=;
        b=ZYVoVQxRRRB7pF/X03WWZpssn4c5Jpl/iwWVqFY2G/ssDb9pwSuwhXjHMfSi6ljDDe
         E6MdMNEyMcIWRlU23HO48okOykAcFLxTTSJVUQgUMVfrVDCxcuJt9SEDTK/jf6b0OES/
         bCTSHmWD09JycauH+0TDapuB2dJDFnUKXaWq2C0sfpFBgsPRI/ZMcO9vK+cMjG0EvXOl
         tdAS/fn5GVQS34i+cruvPUGuiG+l+rjz+m0xZSLkTc/MqrgGuwWgfyd6wzKZyzFcVQVm
         PQd5UaK5QZ3UTAwiHu7PGyyiYOVdabMRyQgwtSz7gfMb3mWLXHpz6QWMBz+Hmo16re++
         YFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xqV0SEJtZbR/dGKSwq8YnqP6PVCCHS5FOV4KkHOfuyU=;
        b=WoKuekQUZ9eWcdbx6TX2G89IrRrKPBSqKfl6LzXg82peaz2Fhqmmut8GjKOxIp9kvt
         mUNELF69Lssi5AYw6VHAl/lfT49meF9dh+YczG8MF5CCXup3fXkfhbFFesdYISo3YJ4L
         I5D5u4LYPx0FYCatg+m6fCdraq1lhSFCsD9P8qNW4oiRTtOINMwpSrxFEzbgOO+Si2Hr
         3bFqk1DDmzZv4rxTdZCrgtn03QCv1ufOWYCnyebPRVJXxo3eLuOhyGfQ/vxdW0LD0MRG
         3ZLKuxaXl09eNXWjDo2CyuDVAEA0GLUgGoz5R4xUXPaTLASGvi3aNRRWpiSifujeDBz3
         2atg==
X-Gm-Message-State: ACrzQf3ozTXryT+P7xhYzlV4GwEKOeqcjWcuhqKwndkS3Xs9PU+dPdiK
        F1/C1iz2/yqEBGZgpgkHP2B9qh4TziWc5SHzULs=
X-Google-Smtp-Source: AMsMyM5gvLxkqtf4uqM558QP37KJk8X8ZsLnmddToE5q0cb28qOdi3KYSxFJyW2x4vqeuN/fRecvKt1f3MP1uyUKL8U=
X-Received: by 2002:a25:8407:0:b0:6ae:da9a:4031 with SMTP id
 u7-20020a258407000000b006aeda9a4031mr8114162ybk.238.1663913114646; Thu, 22
 Sep 2022 23:05:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: andreamoussou252@gmail.com
Received: by 2002:a05:7010:4ad1:b0:305:51c9:23a1 with HTTP; Thu, 22 Sep 2022
 23:05:14 -0700 (PDT)
From:   kala manthey <sgtkalamanthey@gmail.com>
Date:   Thu, 22 Sep 2022 23:05:14 -0700
X-Google-Sender-Auth: 5jQ0pG9ni2oC554uHtu6uR0HmDM
Message-ID: <CAH-QM3Hem6Vrr8mWJFuf4-RZP0KSOoUknvekpe_2SCDQ9BMR=Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi, did you get my two previous e -Mail? please let me know
