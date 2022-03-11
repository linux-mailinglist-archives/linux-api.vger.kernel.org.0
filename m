Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656A64D61FF
	for <lists+linux-api@lfdr.de>; Fri, 11 Mar 2022 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiCKNFg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Mar 2022 08:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiCKNFf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Mar 2022 08:05:35 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CD01C1AFB
        for <linux-api@vger.kernel.org>; Fri, 11 Mar 2022 05:04:32 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2db2add4516so92679967b3.1
        for <linux-api@vger.kernel.org>; Fri, 11 Mar 2022 05:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7JWE9zd+maikJMBk6/jUSlZon4N05PNxWALWeq193Zc=;
        b=LzcRlCsY/gDWi/5XEl4EV3Jr0gn1AMDZ89YJHx4PuIZ43S783gGQPlfJwhazqnjvWO
         DMFOT2vU9vVwik47VtFfMdQYkuE2MFmAT8InJIK78kDvJht8L6Oz0FNGGo0kLcc2215z
         79Xj7nB+loQGI0COltKe/BvfESAaEsdkXl/7VKw72LmN2ZEyRUxQCwuS541AUXIGG07T
         RKTVXKR3GPbkV8E42Po9Jng/qV6/acIxOlDaHDFl+T6ijXjDTNirSEns8pPwaaMuAMEm
         XT6kNl7Z7CTqJBFxyZer3QKo7bDmafYPceF6XMep7RTbJhZ7sv98VSl9XJRho8Uj8HVG
         dErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=7JWE9zd+maikJMBk6/jUSlZon4N05PNxWALWeq193Zc=;
        b=hhdpIXg96bh2OCPOH+Spk2joMmgwPaAZsCUVC2f52DVsNSrCOxlBIdImUYYoS7WYwy
         vu0uKHT8PSbLk9jLGsdUkXYv91X1k/QiWGaXPRGlFIAHLuyhkQLf/GjYocSdNWYR5tNN
         ksl403ymxWCzgJzVCzISay5agiq9hvvzmo1iQkwquQzsn3r6W0ELtjuxNbIhKu0NDsmM
         6meM+y5ChKBwpfjaN9jYuUG/IfiTXUs63yBvpgfQHaOejKm/M4WdgMmMA7W7PJGMGrqp
         n22qbMQoyliVTZ5JeN2ci0X1B8QG5JiWipDNksLbqbLB5SebScbhzQYE+O6JyBfSGqEG
         DAWQ==
X-Gm-Message-State: AOAM531ZjCJ1ZhOwxCCpGPO5JN5FazMHXih4r6150qlaFQULAdhIi1ey
        rYw4UF7apMIsCb2hhK2swP69yA7dSrvQETs4NTE=
X-Google-Smtp-Source: ABdhPJxYw2YH+A0gmSfRnHif0KCih+1iJXmS84AlM7NtYWJK9c9la5Xm/6dY7rxPqVN+f6l/44FDRQeE0CFDWD8/im8=
X-Received: by 2002:a81:98c:0:b0:2dc:1cb0:8c12 with SMTP id
 134-20020a81098c000000b002dc1cb08c12mr7668861ywj.409.1647003871060; Fri, 11
 Mar 2022 05:04:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a79b:b0:238:b5cd:5c99 with HTTP; Fri, 11 Mar 2022
 05:04:30 -0800 (PST)
Reply-To: mrskatarinajanickova@gmail.com
In-Reply-To: <CADt3=2Fvi8PHVZUYFNFiZegePRcwD_yPXtMYGDfU1yedVXhihA@mail.gmail.com>
References: <CADt3=2E9WZbHvrKcVWvpN1_5ZgH5V7vBey1EaMe1C8C+Dvcv7Q@mail.gmail.com>
 <CADt3=2G6Z=i-_yu=FgJvC8X7KW0mSwpk-Hvx=p9cpsX8kRxdBg@mail.gmail.com>
 <CADt3=2Hj3MQo4VgQc_DPEc2dEopKsLVKF7mpfNrKLuiCsNz4Wg@mail.gmail.com>
 <CADt3=2GoNJr4rvEU0wE4C9qC9AuYc5RCuY-NREbz98Y7D+Ps+g@mail.gmail.com>
 <CADt3=2EsDefuzBQbquUZrBNDfue+AzhAr8ErsRCM8OKCS00mxw@mail.gmail.com>
 <CADt3=2E_0Yi_rjH6r4Lkb0Qm1+tL1W0O1tjq3ejemLrZTW5XJg@mail.gmail.com>
 <CADt3=2F9XWLdp8Yk92bY8bPAAQGCWrk6nW14mYrJBqUK3-pwkA@mail.gmail.com>
 <CADt3=2HAhWdFLw5P592KuufmW92fRprT=Eo5pjwwxJB+LiZzPw@mail.gmail.com>
 <CADt3=2HEdbHYAmMN=D5pMPdi_+_LbryXw7Azqxitvu85Gxdx_g@mail.gmail.com>
 <CADt3=2FYduKH7WQgJFQ73Nd_-pyvU76yChCuxbonceFPf9GgOA@mail.gmail.com>
 <CADt3=2HE1GCJXJcmPiQS1a7ByzPec58=StmNcrL2nbDr9Kr-9A@mail.gmail.com>
 <CADt3=2G41a2H-ivOuhOxWruierFeCvZUocYDmhV=PYAtgKgpZw@mail.gmail.com>
 <CADt3=2FgjhAkZKx8EmrgRNe52Mh-g9jnmjrWqKAg5t02DdMO4w@mail.gmail.com>
 <CADt3=2Ex40f6cqk1iNC7_6AsV5Xjovkp=Dmu81+QOL1eZOF2MQ@mail.gmail.com>
 <CADt3=2Gk2fOWM2O=rj33s7N+ph687+d4wE0axwB9dsoZWHzDZw@mail.gmail.com>
 <CADt3=2G=WiWgHRHQFwvT3D0zG+JNB1EErTzUDZdBiP875jK1Ww@mail.gmail.com>
 <CADt3=2F78iNEFJAOLTOcVoOwNRoY7RotJzzMfd4yBU6J30fG4g@mail.gmail.com> <CADt3=2Fvi8PHVZUYFNFiZegePRcwD_yPXtMYGDfU1yedVXhihA@mail.gmail.com>
From:   =?UTF-8?Q?Mrs=2E_Katarina_Jan=C3=ADckov=C3=A1?= 
        <toudignekedi@gmail.com>
Date:   Fri, 11 Mar 2022 13:04:30 +0000
Message-ID: <CADt3=2HQLnHefFmHftPgb+7DnPpXrCx94psi42VLJiDq2puB8w@mail.gmail.com>
Subject: My Good Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4451]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [toudignekedi[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dear Friend,

Greetings to you and to your entire family.I pray this mail get to
you in better health.

Mrs. Katarina Jan=C3=ADckov=C3=A1
