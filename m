Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5F52C6D4
	for <lists+linux-api@lfdr.de>; Thu, 19 May 2022 00:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiERW5C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 May 2022 18:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiERW4k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 May 2022 18:56:40 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042AEE56
        for <linux-api@vger.kernel.org>; Wed, 18 May 2022 15:56:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f16so6165113ybk.2
        for <linux-api@vger.kernel.org>; Wed, 18 May 2022 15:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=P7btzPR/Vle5l5s7elmWUZ9LbIEztS0Dc/XWoKmbneMBSsyDUMsuJq4Ylhmt8/MC5e
         pJc+Ha/GSmxPyR+JdYHJoUFxOoYk9ieaAqtMS8Ad/Z8FFnk0SBrbeexgNWCx1mNra3gM
         hGv2lOHT2ygyJecm9zs3u60rq/z5V46Mv149dQsnD7sOkOVJHrEcjIOxJdOJZzvp2cLC
         b4vuntUJt9jllUw+dktv9HiMdX4t/0QcdotI8yofG7S/s1xzgxKTaTrGFOqfrHiuZaW8
         DOvgPDu3PJm+EZZi2hyjzVQUQQjR4DzqQE3uk3PxTqI0Z4GbZin4x77hgi0oOTRWiqb1
         GaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=cPWPBcpiSU8eK8v6N0da/JY21wcRP9hGX3boby+ZRNo8ugTThzA0rcsV5tvqB1Npyz
         pKZ9BIsK8wWQ3bOxRUgwhBKKVUoMd5qZb6VxIp6G0Ze/Xy9P8hoVBgNpVbVgar1YGLrL
         xQ58rgeA7ypI2UPZx4tED8gX7qYOCXG84S/04VDiUIgECK0gckgAkWSk5KXb6L9lpRh1
         njN4TXuyYNU2IsUwbee5toIG3eslv0EQyz6XY+A69SjtTTV1hHTIyrZB1g/Q0I3WEg7h
         tOIqaik5+bhxzpJXDora7CYtx8gThe3Gg2jeLN/RbAN9oW7cN6dKUHlpA+78d6rokgT3
         g6ig==
X-Gm-Message-State: AOAM531xuu4Y3Mz3qIXSTVDyehRNifafIThMxUFOKolbjPjy4PV0WuCn
        0K+GlX2/cU75z/f/nQhkCROnpW9ioOAHos+Efl8=
X-Google-Smtp-Source: ABdhPJwY8YOdHYUX96JiSxTq5wchI8FXYyVWKhCwVLyfcYrHLYm89em2SVFzx0M4tBmQDsZA/tugAFPK0TzA5I8AB4Y=
X-Received: by 2002:a25:3746:0:b0:64c:4ab2:8277 with SMTP id
 e67-20020a253746000000b0064c4ab28277mr1756177yba.631.1652914598250; Wed, 18
 May 2022 15:56:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7143:0:0:0:0 with HTTP; Wed, 18 May 2022 15:56:37
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Thu, 19 May 2022 06:56:37 +0800
Message-ID: <CAE2_YrBTNWLgT7Gwd_cY5oXmwwHz8Y2=Hv+EONJDgQpe8gV-5w@mail.gmail.com>
Subject: engage
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4867]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [weboutloock4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [weboutloock4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Can I engage your services?
