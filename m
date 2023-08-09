Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C66A7762FA
	for <lists+linux-api@lfdr.de>; Wed,  9 Aug 2023 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjHIOtA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Aug 2023 10:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjHIOs7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Aug 2023 10:48:59 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CED26A3
        for <linux-api@vger.kernel.org>; Wed,  9 Aug 2023 07:48:43 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bba7717d3bso5264412fac.1
        for <linux-api@vger.kernel.org>; Wed, 09 Aug 2023 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691592523; x=1692197323;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=TFpTZUOXTWGH2dpk84uuN4L6ztryfTr96HRUjBEUF/bDYTV0GwAkainCgGwHgdbdTe
         d07gN8DD4U/nx+y71sFYnCPa675SEgLk9C0duSfLbXQ3j88qfZCM0bJF+D+m9uVSbQz0
         JTFqEjBzmgDfwbmlaK7VTTpcaJtQStuqyG/cujDxOff8GPeWsZ661HEvidVdYbEXYlH2
         601QcUlnYSAD3FRo8si9Dg+/HRANqJzInsYGaAHfDB7mAS6INmt91Sk79fpu2VVmmZcx
         vOMvKKGAd/PavW5SXnW5kRFgM7o+Lva6IYtjHhv9MBoiexfokJe4DZYKCz2lPviG+/CP
         YF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592523; x=1692197323;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=glf9zbyGH0KLHpWO4ciWbVPhEEKFZ7Q86Cx9ui87hvFTS1J10BG+NlzZR/8Prtg55S
         TDZGclKF8qizeYIchvmt//FIetBRWEr3bgf3QDxFXQ+aau3bbni+BXT3HpFAzcJ/+Kc+
         LMBsZmUqrpiN8p1W2V2/0EM0uO4YSxIN9frWs2rvtF5rRnvqSNbMChxegGq0jL9PuQr8
         zZM4aOsqrP2iXzpSm3ytiqqM246WwFk0XmlvigYPXZVNNlJ+l/8wEqbaqvxVaRFDt1EU
         12pCSWGfD3fj+EFK58OzdD9hKW9G4HM5GAWekIJ3DlM5p8V+UzAQpFSrQVhmvG88JXLe
         cxoA==
X-Gm-Message-State: AOJu0Ywh8M2So/4hMZGOjVfVesZwFK69PylO+etkYm8oyP8+73n7yU66
        s/ddIVeNBnaqNpWmD3hov6Qew6eh2e1OQzf17tA=
X-Google-Smtp-Source: AGHT+IFnMZV/Tepg/pxXNz5F327VvxgIC5AAq4V7oF57jXkkw29n3YX3lFruJAcb/8pvZcuyqRBt09/suL4PouBwbFQ=
X-Received: by 2002:a05:6808:e8d:b0:3a7:53f1:16ac with SMTP id
 k13-20020a0568080e8d00b003a753f116acmr3364392oil.20.1691592502384; Wed, 09
 Aug 2023 07:48:22 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsthereseninna@gmail.com
Received: by 2002:a05:6358:71c3:b0:f1:be9a:c0c5 with HTTP; Wed, 9 Aug 2023
 07:48:20 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Wed, 9 Aug 2023 07:48:20 -0700
X-Google-Sender-Auth: O7I42bblFw4V1Z1d3Ig3xne0ObI
Message-ID: <CAKVHDg846kpmnnkkdAMdnF7=uH8_CQyTkfzxvf0swbgcKOZ+2g@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
