Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7780D575FAB
	for <lists+linux-api@lfdr.de>; Fri, 15 Jul 2022 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiGOLDW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Jul 2022 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGOLDV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Jul 2022 07:03:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279F86898
        for <linux-api@vger.kernel.org>; Fri, 15 Jul 2022 04:03:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v15so1583270ljc.1
        for <linux-api@vger.kernel.org>; Fri, 15 Jul 2022 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UE1FrYoch4YdKD+Vw9+azGNMLjwsFgEirxtfoByER8w=;
        b=QztZdBwKoFsOeb1QRpc8F9mLmNDlKFq09Ktg+h5qqtzSbUSuYEHvrEsknK8NSaRh4z
         edMyTEw4sviIdPKErs/lnA+M1npsarunjfhCdOvGb9pO65A5/1AWYMP6VVmOD6QmVzP5
         dDOjoVexY7iwQCq2vpU8E0jcpFGX/0rMJ38v+Gow33fUSmx7bnAtWwzJ7Txwpju68SVY
         VMmKiuo4LKNOonHuqx/PAjiGrwUi/NmJkT1XVydsqPWf9PX5wkHLP1nkLSl3cQ1rZfu5
         1hUsBcAc7B06Y/fsPJTL5SsyL/pJ5UlIJMpCWFZyoD6lKLQ7R3jLMtxsmPEejo2G8s3S
         l8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UE1FrYoch4YdKD+Vw9+azGNMLjwsFgEirxtfoByER8w=;
        b=6LMsbD3/DoFIzla6rNUylI2mNtLrtwJz31HcccnVXaYJv2r+5yN26J0EZRrgLRrmEn
         r4XgjaxyRiuwvB8MmzjpBqI3eyjG0cDfqi1o8gpgsfP7HoiBcAP3EMW0FXn9di50iHuy
         4Yypv6XAt9WCE8EAIxqVTNwc7awoCzMGkDrqHROHN8/ku9yXSia54AL/2/V7Gv0sK0bH
         pfwmyDZCzk9RonXdc+WJj1RORNs6huiKh4sNENMZrfxX2VKEBRnH7vQ4QBZupP7PyrOG
         j8tBmQPZ9HWev3b5SHNR8hsTnmvBbZ2iRvB8eDsLQJk15kw+oBEhCok1qdWybJ6UcA/o
         kWOg==
X-Gm-Message-State: AJIora/eiZWygM+dlGIxLxckzqetxfjobElxMDEbHdap48Lt4irIC+/w
        k87dlnKB02Qh0dt0XCxB0Y3Ubwq46+XNTFkFi5pM6WpuOERcaGnnCEjw+A==
X-Google-Smtp-Source: AGRyM1vPu+3r36+2Hbj5vYA2dOnJOuYed9LbeQ9UFz7KxqwXK1JfLWTLkK9E53leGn/k5Ewv9S5L/0ZWivRJC2nF+5E=
X-Received: by 2002:a2e:bd86:0:b0:25b:a4b0:bccb with SMTP id
 o6-20020a2ebd86000000b0025ba4b0bccbmr6685709ljq.439.1657882995435; Fri, 15
 Jul 2022 04:03:15 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Babayants <babayants.alexander@gmail.com>
Date:   Fri, 15 Jul 2022 14:03:04 +0300
Message-ID: <CAB92dJbs0tcXmnQLZ5QKT4MJ+Hfbj4tr_HyFeaL=ySLHEUQxUQ@mail.gmail.com>
Subject: recvmmsg() behaviour with MSG_PEEK flag
To:     linux-api@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mtk.manpages@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello!

The behaviour of recvmmsg() with MSG_PEEK flag confuses me. I'd expect
it to peek multiple messages at once, but it seems to peek only the
first one, filling each of the provided struct msghdr with a copy of
the first message. I do not see if it is documented anywhere, is it a
bug or intended design?

What I want to achieve is to first peek into the socket, get the size
of each message, then allocate appropriate buffers and read the
messages with the second recvmmsg() call. This seems to be a
relatively common pattern for reading single messages via recvmsg(),
and I naively expected it to work with recvmmsg() too.

-- 
Regards,
Alexander Babayants.
