Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800A25ECC99
	for <lists+linux-api@lfdr.de>; Tue, 27 Sep 2022 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiI0TCD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Sep 2022 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiI0TCA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Sep 2022 15:02:00 -0400
X-Greylist: delayed 255 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 12:01:59 PDT
Received: from fsfvdiej.episotheque.com (fsfvdiej.episotheque.com [81.161.229.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B50D1BB6FD
        for <linux-api@vger.kernel.org>; Tue, 27 Sep 2022 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=episotheque.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=san.con@episotheque.com;
 bh=BUrnWHy8nUdGJERYd+ZXpdOaFjc=;
 b=CMrstK1XCp4w/s3odEiBeVkI8gCtBtSSKbmykxPl8QzunrXmq285NtYdEJiryyKfvLcCEYNU9hVg
   agdLvA7DwHY+O2JT4vB2nY8sqqAV2QQQjUbSOi2Lb8zVClf016pmQo6pEyfGMn6NcWnztkaiZlxQ
   7YEW22VfKw36uTsjsuKy0e1fN9n2KQXCBrXPp/SCDtKF8zc91/zLe2mtqBChuerNhs9Km3uPOoY7
   KCv2BRB3F5sGj1PnnkNAKL6tE/yCoDnONGUFi8KF/ydW7VTBuNTUti2HPlm8K0bFxNZx+CY4/hHN
   GE+BFU2JYn85AL7UH44bHtnsKWHmdQrcUS+IHA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=episotheque.com;
 b=y1Dm3aheFWu3gQn+Mf/kUSMmNyx4ez58FHrIEwIlgC7CYhEsQKq1iuCfoMTijZL3FY6weywjOLTM
   BXGSaKzyQE0mzx4SSp6yFogfyD59I36A9g67twb0lxSonLVJzshJxi9PYGFQqbPsO9IZgrpTmIej
   pFNNOeTG2Sz7cXYvQUe1qkjutNQEDgCB9qh0niaMX7aLjGSzXzfsmW0VkYLCZdsAYWVyJGg/pkLs
   KZEYZMelQ6VZOPFZrfhJ8DZl0BJccFFWxefOMm4+cMvyVQWQxZrEEjHU+VNJB5hOtI3vrr3rGM/B
   QIuRnf7wAT8kTaj3IpBMHhzhl6rS9ZucrB+dqQ==;
Reply-To: kolmandonald3@protonmail.com
From:   Donald Kolman <san.con@episotheque.com>
To:     linux-api@vger.kernel.org
Subject: IMPORTANT
Date:   27 Sep 2022 21:57:03 +0300
Message-ID: <20220927215702.5AAE331CFA8C7718@episotheque.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
        *      [URIs: episotheque.com]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kolmandonald3[at]protonmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello linux-api@vger.kernel.org ,

I know it's an unconventional way of reaching out to you but it's
for a good cause.


I=E2=80=99m Donald, a Research Assistant of the Research and Development
Department working at one of the leading Bio Pharmaceutical
Companies here in England. I'm looking for a reliable business
person in your region to represent my company in sourcing some of
our basic raw material used in the manufacturing of high quality
Anti-Viral Vaccines, Cancer treatment and other lifesaving
Pharmaceutical Products.

This may not be your area of specialization but it will be
another income generating business out of your specialty. This is
because Our company is yet to locate any seller to buy from,
however, I have been able to discover a local dealer who can
supply us with this product. He is selling at a cheap rate ,
which is far cheaper than our previous purchases.

I will give you more specific profit details when I receive
feedback from you if you are interested.


Best regards

Donald Kolman
