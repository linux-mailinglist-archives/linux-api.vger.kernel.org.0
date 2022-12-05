Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94354642BBC
	for <lists+linux-api@lfdr.de>; Mon,  5 Dec 2022 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiLEP26 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 5 Dec 2022 10:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiLEP2j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Dec 2022 10:28:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F9B2626
        for <linux-api@vger.kernel.org>; Mon,  5 Dec 2022 07:27:03 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v3so10794632pgh.4
        for <linux-api@vger.kernel.org>; Mon, 05 Dec 2022 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTaksTMhrvdwxwSo2T6GMW0VI0cIQaqvSTpIlmBV7Ss=;
        b=DeU03rPLUdchElNhZSnVTjlCs2eNksOMONdHq6QbA94lZUPSr1MksYOVcPVSVz6yDP
         s4tI+LPlFLIQ72vA1tbELCcLqSCa676EJOMD9ztrAi18N5RAj64ZSKEtIcce6ROIVh/G
         udulq10NlwhGMYV6RhKCNfEMFRCl7hGGhu9Svg9HYjRQyzZaNGkax84FD6DdYYtPGL32
         Q36eqsj89UjPlraizhSpYbXlcFs3yVh3ezGHTdo2JzbaNVXIu6z+uqQ+wBLljCZWJk0S
         IPJ5RC/vzSBg4DX60+zvEG3l/6lXUnokv4VNiJCKoPZRytojepWwkZRMXqGxFOwX4squ
         RL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTaksTMhrvdwxwSo2T6GMW0VI0cIQaqvSTpIlmBV7Ss=;
        b=2KyuKec4e+z9HJrXFJdxKQ2LKuX/UKP0WAYxJoZnJFn+D6k4j0+0TFhDzyGzCNXlUH
         Z/7prhZFtcHHVC0b2tk97A1L/lpISgP/YZIY6rU5VkYxuWFbkasfMMY9FlLpg4Qi5D7W
         koIb7zlH4FF2X7FrT7jUoHR9yW0JADju1+dCWlGzy0mf5XGbe8LJ1lXuUO/vLnO9PA7W
         xo5wDZBaD2cIJgdCV2M/Kl7aKrWAxvm0/ZvrhTaI0XzJj1BWPDwq8rRrKYJD7kU4fUz3
         ch/jpzr03ilieEKAdk/cFNKgISl+YhA/qi8GMqWVnKfV41ySBfZSC5SGdPq6oUvpUyX4
         g98Q==
X-Gm-Message-State: ANoB5pn0BR24fRDpoWiVwCOuElLTPw488DeefRI80k7R3ORb3il/xBpg
        mr8XpOdo3NMLDVtaOfdTF2YbJNAvOsIev4TORk4=
X-Google-Smtp-Source: AA0mqf5D/4QG6PNyqls/TBPlts+Y3hNbrNxeIAUFThK0LBmAS9ACBqVldaPYHHkik+PRylXjsZWnPMTBCGg7kDXSjWQ=
X-Received: by 2002:a63:4643:0:b0:477:751a:4169 with SMTP id
 v3-20020a634643000000b00477751a4169mr57646081pgk.300.1670254023534; Mon, 05
 Dec 2022 07:27:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:248c:b0:47:300:1003 with HTTP; Mon, 5 Dec 2022
 07:27:03 -0800 (PST)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <atchrimiv@gmail.com>
Date:   Mon, 5 Dec 2022 15:27:03 +0000
Message-ID: <CAO95NvWV2mdYbQetuAFhHMKqawMuvRjbJDxn8Dk06jxazw4fVw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 Please, did you receive my previous message, thanks.
