Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE9538499
	for <lists+linux-api@lfdr.de>; Mon, 30 May 2022 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiE3PSi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 May 2022 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbiE3PS3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 May 2022 11:18:29 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283AE277F
        for <linux-api@vger.kernel.org>; Mon, 30 May 2022 07:20:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z20so11481772iof.1
        for <linux-api@vger.kernel.org>; Mon, 30 May 2022 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=Wc9YLfir5ejlsDTz4KQpGBf4urVA/F2ogmC6FfLeyv2RCfAOeKFzlKlppzhHItc1Bq
         vHeCQtNTz/suh8kziWhOIun4oCdQ4RIPux43jF2U4bgOApJU9XCDG1w4vwb3MsA82kNB
         9Us6Et6UQKfU5aAUEkHyGO8whgTbLWqra46yHhqF9o8unKDP2lnDv9363PKnmlWJsFuP
         RGcG16haNPz1H5YFR+Z69B0Lb5RGSmlriOSJ8Ug7l9qtBzq4bXBEkeuNGIA/4zpMB5DK
         bfHRx1y5TSGzlgjuVF4KMQFM8XYReKP4ZLbwbj6wzk0akZy9rTPRtxkpaBCYv6CNuDRE
         aMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=25udWCNeQ/ocETaNILrREff4TZ+1WBTFt1qO0NwnCWSVvjzF6BsIwc+uddlXtlhEkq
         IXAKNA27Aon+OPdXcQy8Uwm3QojWw+xavFWWFxcatmtukDhpeuFjraIkgyktjakAoIlJ
         nRNT0xMTeGHFUTbrcQXJd+kMI+cT8gtayt77Ett4QFwO/Er0dzh+lIdw0lJ7npAEW2Al
         PJsJVp4jODbpssaBqZdyrp8d3Rd5IbjV7f3EckRz3sDoQ4GsVc4nl2Pi+Wymu1MpN/5a
         61BCdukjzh7jCinlZqaOP5PRpUn7rpuou6jwhhVirLVj1qeGO+E9INScGYXlZ/o560pB
         gwRA==
X-Gm-Message-State: AOAM530jEOGFC3xyRjpIrkam6Cn84lak98pZ4RARNBOK4Gjcy9ez/869
        ZsxHmjkKoA72One3WbLtUrVe+O2ej8ckXglIRnY=
X-Google-Smtp-Source: ABdhPJxjpQKM5stogsglVw1vjymm5n5jVJgWw3WodUvIBLYuGZKRRDdmP+WUPpKGpZhiKarXTScRvxVkvgg9P1qoYdA=
X-Received: by 2002:a5d:9d95:0:b0:663:c256:e19e with SMTP id
 ay21-20020a5d9d95000000b00663c256e19emr17055181iob.7.1653920424607; Mon, 30
 May 2022 07:20:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:f06:0:0:0:0 with HTTP; Mon, 30 May 2022 07:20:24
 -0700 (PDT)
Reply-To: barristerbenjamin221@gmail.com
From:   Attorney Amadou <koadaidrissa1@gmail.com>
Date:   Mon, 30 May 2022 07:20:24 -0700
Message-ID: <CAOh7+P-bAv+p1s5fx2Lazi2kYkmbqXrXk85_k1cAiBH4_HUV1g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d42 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [koadaidrissa1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [barristerbenjamin221[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [koadaidrissa1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGVsbG8gZGVhciBmcmllbmQuDQoNClBsZWFzZSBJIHdpbGwgbG92ZSB0byBkaXNjdXNzIHNvbWV0
aGluZyB2ZXJ5IGltcG9ydGFudCB3aXRoIHlvdSwgSQ0Kd2lsbCBhcHByZWNpYXRlIGl0IGlmIHlv
dSBncmFudCBtZSBhdWRpZW5jZS4NCg0KU2luY2VyZWx5Lg0KQmFycmlzdGVyIEFtYWRvdSBCZW5q
YW1pbiBFc3EuDQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCuimquaEm+OB
quOCi+WPi+S6uuOAgeOBk+OCk+OBq+OBoeOBr+OAgg0KDQrnp4Hjga/jgYLjgarjgZ/jgajpnZ7l
uLjjgavph43opoHjgarjgZPjgajjgavjgaTjgYTjgaboqbHjgZflkIjjgYbjga7jgYzlpKflpb3j
gY3jgafjgZnjgIHjgYLjgarjgZ/jgYznp4HjgavogbTooYbjgpLkuI7jgYjjgabjgY/jgozjgozj
gbDnp4Hjga/jgZ3jgozjgpLmhJ/orJ3jgZfjgb7jgZnjgIINCg0K5b+D44GL44KJ44CCDQrjg5Dj
g6rjgrnjgr/jg7zjgqLjg57jg4njgqXjg5njg7Pjgrjjg6Pjg5/jg7NFc3HjgIINCg==
