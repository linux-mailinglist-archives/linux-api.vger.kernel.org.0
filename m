Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA0655E38
	for <lists+linux-api@lfdr.de>; Sun, 25 Dec 2022 21:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLYU3z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 25 Dec 2022 15:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYU3y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 25 Dec 2022 15:29:54 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044FE266C
        for <linux-api@vger.kernel.org>; Sun, 25 Dec 2022 12:29:53 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l29so6559851edj.7
        for <linux-api@vger.kernel.org>; Sun, 25 Dec 2022 12:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyCJn3mkmw+ESg9zrGKRNmpcUePCPcwxxcNX7KsO7rY=;
        b=LWmAvHvqgoU2AVWvabwi/bSOPGgX2jNe5lynLgZiH/GTQ6kMqijIjBFZRLZQ8DoHkE
         P/1ONwaPmXQN0fFeHtsaE8GVtH5qU8ZL45mECon3K138BVW8ScE/OgpYupNW5BorD0at
         iIosyef/s4SqX02R8hJ7XorCZ2dk+4wtx4m3uIBugW1sC6rcYk4nzR/ItdEjbZ0AmkM4
         EcwB+3Bw6WqXgwy/g4tvyz2apACFMmBIAfrbt91aKpqC2L1OWIq/e4m1w7x/JarQ35fM
         oAxLOSzmv6loT6Vmh5Is+jlScsY4H4TjTvRW1u3jkimYgBVTNTxH5DucESXa5HyBu1O8
         8SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyCJn3mkmw+ESg9zrGKRNmpcUePCPcwxxcNX7KsO7rY=;
        b=qtxcoIyhPb5bxP65zNGYalSR8jDqO7DrFWSY9jdRsulB5BjWDZV+gb4DeuN9TAoK5A
         ehO/iLWfic8RTnva0YdLOOoP0il/L6nJvrA1nrXcPp7tzWURFg2Q44TItl4IO0rzQJd7
         q09RlKSD2mScOorY+QbgHdLTBfgi4tL46PxHBQSxhNgfNwNLgvFumyWakQAzWcJZL2v2
         3XcLImHu1pIFYpcYEurl/UbPp9MKeY5LPr8Dh8r1g/GNO8wMoNFOYJSksn9q2K918iMx
         IVfzps5/f+6aTLAa45ik5BExZfJ5Q8pPx3ax/U3k7+wVP9P2CCJrUYcIT8JVsX3Ai0xs
         /IFw==
X-Gm-Message-State: AFqh2krPJ+CTqe8M/3Oupg2kwMge2PhxC791pHzX04tcmQgOK4FEOpNR
        xeGgEx4/F2SiifYabsDJAH2bGQvHFvUkhVmx+iY=
X-Google-Smtp-Source: AMrXdXv5vtp4wSxednPmQGJrQHPstNCio46nzZ7tLuMNKzQFjRZJUsTpHgqgQdXRmq7m8qxuczKCWQTgqsUUmPpbSHw=
X-Received: by 2002:a05:6402:158d:b0:46c:38a3:849f with SMTP id
 c13-20020a056402158d00b0046c38a3849fmr1216169edv.279.1672000190743; Sun, 25
 Dec 2022 12:29:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:523:b0:28:a068:3750 with HTTP; Sun, 25 Dec 2022
 12:29:50 -0800 (PST)
Reply-To: wijh555@gmail.com
From:   "Dr. Park Chang" <changpark600@gmail.com>
Date:   Sun, 25 Dec 2022 12:29:50 -0800
Message-ID: <CALzKYvNp1goweZtwyuQti=nh2=Gp4fn1jvC6cDE0vDSROYO3dA@mail.gmail.com>
Subject: Very Urgent,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

-- 
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Park Chang
