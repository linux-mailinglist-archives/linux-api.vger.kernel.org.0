Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4C244404
	for <lists+linux-api@lfdr.de>; Fri, 14 Aug 2020 05:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHND5M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Aug 2020 23:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHND5M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Aug 2020 23:57:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124EC061757
        for <linux-api@vger.kernel.org>; Thu, 13 Aug 2020 20:57:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so7314306qkn.4
        for <linux-api@vger.kernel.org>; Thu, 13 Aug 2020 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MTuDeV+j3fzgYR5SGPLvxT4ilKSMnNxei9P2lIEnWw=;
        b=bu8dsCQKjF9Ov1Nw/qa5ydaYlZbu9Dh6UcAUBcJTG+6J6AyB2e+pghxSPQTGxvMXmN
         XgviDf2W8ZDKqcRpdH5TvHcp+8GApJWFRHcEQ6S7IJXUnssSYf2dR9SWehMkLbAT1wUQ
         9UZXldPpU5EV/UCSMyOkw2IToGLNbo7hbaUmnAOjUhKVZaQzXhCBaEnP5usyxGLZO5by
         wch6njTGkPo3xSmEXOPemOmVWFz8sOXB99nynjJ1Z29b6FQfh/hqjnx+xEh8eq48VoW9
         kgGwTdhfawQmH/3mx2OmEyZevcwsSLEiEhgZ4uTIh9S1L/l1mN6hbeOj2E4Nb68IKO7q
         LF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MTuDeV+j3fzgYR5SGPLvxT4ilKSMnNxei9P2lIEnWw=;
        b=tYbGtL1XxSogFoCBu/nj4EnUQdudiRzkrvNQok4HPP3Byy3b5Cpu6hgOs76Nc/3Zkf
         pcrz8nZe3N7IUsTsJ1Jl8DxVMF9iFii5GFBlv3nRp/iTAKH5uoaPXyAyEASD05BMHDMH
         QpSKJiueHmN2fpABIhjTezRAPBNfbKyjv9kLPMJi/fMZr5newNo93pzUj2Wa7j9xvXtb
         LCevjRv8SuYORizL2WKhVz+mSxrhzZ9PtRge82tsNS27LfimL4LTFVcRkwJ4LiTLQuWA
         JEx2uz4HgM0TAoqDxuV2wvYH3ZIPRfTCfiSCRB7gWslzQiErO+RlCIArW5DU5+8SekED
         Ok2w==
X-Gm-Message-State: AOAM530XiOwTMAF2owpKB9Dyu2MqdFf+qUz8pqeVgXIN6s+U17Tw7dnV
        ov+Q4rZlA9Bv6p50C7tCcWmYiw==
X-Google-Smtp-Source: ABdhPJwgDgLg7M2DAbRGUL+XBzE0jRtctTh0Je1JKmoNwZ7TJym5ipZUwDFbNJ2SYTiezA6zG1uDlA==
X-Received: by 2002:a37:5b41:: with SMTP id p62mr387011qkb.369.1597377431112;
        Thu, 13 Aug 2020 20:57:11 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id k11sm7229460qkk.93.2020.08.13.20.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:57:10 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Pascal Bouchareine" <kalou@tfz.net>
Subject: [PATCH v4 0/2] proc,fcntl: introduce F_SET_DESCRIPTION
Date:   Thu, 13 Aug 2020 20:54:51 -0700
Message-Id: <20200814035453.210716-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is a first attempt at taking Alexey's comments into account

This goes against v5.8

tl;dr in commit 2/2 but motivation is also described a bit in
https://lore.kernel.org/linux-api/CAGbU3_nVvuzMn2wo4_ZKufWcGfmGsopVujzTWw-Bbeky=xS+GA@mail.gmail.com/


