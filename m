Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD378DC89
	for <lists+linux-api@lfdr.de>; Wed, 30 Aug 2023 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbjH3Sp7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Aug 2023 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbjH3O6h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Aug 2023 10:58:37 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C9A3
        for <linux-api@vger.kernel.org>; Wed, 30 Aug 2023 07:58:35 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a7d4030621so3310364b6e.3
        for <linux-api@vger.kernel.org>; Wed, 30 Aug 2023 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693407514; x=1694012314; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ne9aFrKiO5G6mZNZ1OfJpzxD3ApR20ygsQBZTQki3YhSuNxAZGY5Jq53QyAPQPe5x8
         Xukw3iBiwnhEXW/QDt0tRB7J+ZxooMJtkMYEP+6T5sZ5ezsLWkii+nxFjH357av9Aaz8
         2SLfiYzyRR1mIJA8Yv+uZO9MFHV78Pzhhu9IqhXi6vPoLo3T37jJ1Z9OLQeVrNWIDwA3
         4RV+UeATpfTRWK/ra43MqgsYLhNXfazYGOmlH21Iodeyd5xnMjyvpQKK5ANt0hj3BQtt
         iIr3CPuv8sIhNGTYYSoUURD5SX7QMyGVaoXxROuKyKsgVt3ANh4tsH6/bwdio5ppsbwr
         JVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407514; x=1694012314;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=M7d4QpFXppZlhAnWWgff4GikCaBrmYKuqD06FggmzaEZP8XzvyufToBOlZJ99PaSS4
         2CImPorVEAkLZbIuSXVpCDbII9QaKAHLsFRG7696KlIdaScPbPx3B6qBOg1FrS9/HDoa
         S/VK83JvTqT4JgT0TWePWPomhROAND/NETM2m18fNrP6N06eMzKrCSm7Wx88ioyQGo1g
         2vYt5UJ5T1/+tJlrCyQpdhh4kdwrc36jXh1USljUSgipiJaUEQSrB++TcLvk7FkO6Kv6
         VR9RR+AeZnYtE5exoEoQvBBESM5kifJKzR/DFBTiwuUnPPX1qgII3zSGJVWdqJL+cJTF
         YbRw==
X-Gm-Message-State: AOJu0YwTE2+zNHegpyPTbYmTMMvpBAPn9iEgZENJo/KNkuQYQyZMqzqa
        odSVAWI0xsflB3EPmzZUVatxrC7Q0nvUzmpSoeo=
X-Google-Smtp-Source: AGHT+IEOTNlNko/RrVpS11C1eDX30O1ZEMlZxmqpmb1dX7yP6JyHiVHTphdKIVS7arXBfxlGxyvZpaZ4VIUQWz+Xxq8=
X-Received: by 2002:a05:6808:8c8:b0:3a9:cfb5:462a with SMTP id
 k8-20020a05680808c800b003a9cfb5462amr2171639oij.36.1693407514574; Wed, 30 Aug
 2023 07:58:34 -0700 (PDT)
MIME-Version: 1.0
Sender: shuzhenguanting@gmail.com
Received: by 2002:a05:6358:5242:b0:139:7036:f477 with HTTP; Wed, 30 Aug 2023
 07:58:33 -0700 (PDT)
From:   nadia osman <nadiaosuman79@gmail.com>
Date:   Wed, 30 Aug 2023 17:58:33 +0300
X-Google-Sender-Auth: zHeZN7zEuwc1OTS1ufhWnMQlRnY
Message-ID: <CAN74TcCDxmdqWr-D-=zAZf_HGU=fdvjXWuBSvpbuam6YRZ6Azg@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


