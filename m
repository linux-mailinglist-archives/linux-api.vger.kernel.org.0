Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD57295E2
	for <lists+linux-api@lfdr.de>; Fri,  9 Jun 2023 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbjFIJvz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Jun 2023 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbjFIJvR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Jun 2023 05:51:17 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903159D4
        for <linux-api@vger.kernel.org>; Fri,  9 Jun 2023 02:44:23 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso6755075ab.3
        for <linux-api@vger.kernel.org>; Fri, 09 Jun 2023 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686303860; x=1688895860;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KiJEQz+iolQoqVlQneoXuFgQ9O1w6nhH9uLF2YArfbM=;
        b=PPT0RtZeix0jte9IJFQaIQl2Zvvg/qUkdjtorSMsQygsiHeWRwauZkGVXnTsN6+Z2V
         bUWwjOObRYuWMIPqurVRE0m9Qxo7Hm3ZU3yYDzE8HRrh/LDAU2qr5COCbHMyFGEM8yxr
         n5pZ78sOb7Kb8xhFOQ080gVAq31EJcnM+HxKSjMBgz2ZikS84e9hdfRWDwEhG0H2Bum9
         u+uSlEkXJH8g8jv3MD+/aOVUHrt/aNA8nvoVxs1WSL5nm+qxHyPZrK1KkaOxS1G0nu+z
         XK2PUToiDsSizgrSnZo4OTXODKYSnf/b/mAV843ipq49YMt5QiM6xFrxssEC03t9vSbY
         Szng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303860; x=1688895860;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiJEQz+iolQoqVlQneoXuFgQ9O1w6nhH9uLF2YArfbM=;
        b=e3KI10biysuREYnknyEmb6UzS58VFkFaC7yc0aXmFG4WudpIKJRtUABvNaZowd/drp
         dhU5rDJm/AWNoKUkajBB8NVmRywpBOYrxa/i9y49GBZ5e/MHyllWptYlmSnI1Lt4plhp
         3svUqXEquvde755gKdK6N4lp+5thW1kjisKgRi+dqx4z4oBdYMXe2W4ORqgieQ1Mpc0C
         memPEYdQGOAWLYhR/8nYEZw8427WVIfNGIF7TFq+MKkemlEVlb48Bywl1a3mw+5muNHc
         PHjJ36dLja6uYxZGScRmImJ2t8kX8rPBRAXEyDrz5PbwG0l38lYmndLS6mBBnFaSr5s7
         zQzw==
X-Gm-Message-State: AC+VfDzEhzpDvNLmSfsNM+mdSIQfE2xK6oj8d/G/R4fOb0gG8IZEl5WJ
        3yHHNwyvIH602n0ZAB12Oa21w8UOaKiIGD+Nx1Y=
X-Google-Smtp-Source: ACHHUZ63SxzKjAoySd0k6SYIx7C/n0PTs0jQ54Bp4W1pzPS5F1fIbir+2WGWZjd50ZN5IQ/uXeUpvQx2FoJgnaOXMZs=
X-Received: by 2002:a92:dd01:0:b0:33d:6988:c000 with SMTP id
 n1-20020a92dd01000000b0033d6988c000mr1332753ilm.8.1686303860583; Fri, 09 Jun
 2023 02:44:20 -0700 (PDT)
MIME-Version: 1.0
Sender: hj3849583@gmail.com
Received: by 2002:a05:6638:2413:b0:418:42ed:4eb5 with HTTP; Fri, 9 Jun 2023
 02:44:20 -0700 (PDT)
From:   Helen <helennbrowwn@gmail.com>
Date:   Fri, 9 Jun 2023 02:44:20 -0700
X-Google-Sender-Auth: ramZUtLmCXgssANGtcw-UKg2Zac
Message-ID: <CAP1zvwCSW39hKU0umQd6D46T2vjzuUgep69QTab6Bk_HUcjVAA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--=20
Xin ch=C3=A0o
