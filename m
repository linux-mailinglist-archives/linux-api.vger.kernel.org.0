Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC957AA24
	for <lists+linux-api@lfdr.de>; Wed, 20 Jul 2022 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiGSXC2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Jul 2022 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiGSXCF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 Jul 2022 19:02:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427805C976
        for <linux-api@vger.kernel.org>; Tue, 19 Jul 2022 16:02:02 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h62so29122161ybb.11
        for <linux-api@vger.kernel.org>; Tue, 19 Jul 2022 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=IidRqp259LnIGwKSY8eSnwY2pSvVpnXgD6l4DtZ0nS1en5/eIODexxA8HY1P3fOj1G
         k3L2dqT2adyYNMP0Xveqboy+8rHiXHxkUk7eN+Z4c1u4A1dmYZTv8XeBq3Mcqc8JpY/J
         Y+FZqCw+ctBHW93xydCMO1T2zbJgKE6zi4yOKnSgCU0wXAb68jTgzbksOw/WF0fuySr4
         IszSqaPAblIoqFUVbDoenHDcU4oM8zz2T2X2YOFu4paIHinYHYAEpHDagNDILO9VwXpP
         1+8RZDNcKixJbUOVKzMHhr00ZyE0o1uffduD4Jla0qSaybMZB4f9mMaQZtZwFiKbVkVp
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=fCiU75RCGPY5eohnIqex3Hh7GrS6Mc08BNSnKdd1v384heP+6lQlHgprZanM9sYyjH
         Fc0Mo4IjpGCucfZDB1DnJ8kHbg/CcnvALSBNNB1YrL7XhhwL3HUdNL765S/5b/uYmr3c
         RUHtToM21ZYiIyFRhgIHI0oBvUHdB2JycbC6PC9F2SZONcdd+S9g9RUvnW//N2c4Yrf8
         47bKS/XqzIkjoEz4a8nL58Fzwiu7wQNZsUHVlw+8cLq675N7GxgA8BWMKJptjjfsp+1t
         TNKFeEmgqvsa3+3WiSytQSEQmT9GQfI/hmKhvenF6smvSjMaRSU1lryxZnTENHSE14FC
         xgGw==
X-Gm-Message-State: AJIora+zQbhpDDeRsqq3yByxYZ3QLQRQqBVOomV9XaGuPNaHtz7d1gTQ
        aK/ZMEGpKxOrf8fb9gQvHSht6C2mXaEGyWzHHuU=
X-Google-Smtp-Source: AGRyM1sl0J4NyfzC2f29bqXT9oPchs8cDVndRHRbS2Q3refz6ns6Y35SIupBWILMCNYHx3pJ+wk7AlhI9UdwA1sMqK0=
X-Received: by 2002:a25:850b:0:b0:66c:d287:625a with SMTP id
 w11-20020a25850b000000b0066cd287625amr35727355ybk.31.1658271721069; Tue, 19
 Jul 2022 16:02:01 -0700 (PDT)
MIME-Version: 1.0
Sender: belloashawu72@gmail.com
Received: by 2002:a05:7000:26b1:0:0:0:0 with HTTP; Tue, 19 Jul 2022 16:02:00
 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Wed, 20 Jul 2022 00:02:00 +0100
X-Google-Sender-Auth: BO4DmyfvjRINBOwOOpcYOq24sHk
Message-ID: <CAOjupQKQ6zRjFB_6SefXkEmKaf0_dwC_KfS2LmZFQLFEaDr30A@mail.gmail.com>
Subject: My name is Dr Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
