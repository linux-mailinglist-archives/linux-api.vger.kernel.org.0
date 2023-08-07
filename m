Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEE77305D
	for <lists+linux-api@lfdr.de>; Mon,  7 Aug 2023 22:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHGUfa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Aug 2023 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGUf3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Aug 2023 16:35:29 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326910F8
        for <linux-api@vger.kernel.org>; Mon,  7 Aug 2023 13:35:28 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-583f036d50bso56627767b3.3
        for <linux-api@vger.kernel.org>; Mon, 07 Aug 2023 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691440527; x=1692045327;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=WGuPu7g6E23RXr1v5LnKJEwl5/NhLHAEmhF1044iAo3zlPa7q/dCiC92JtWaTvN7LN
         bVXSSjM+IWwdQf1AGsnUhtt0TLD2CCmfvj8Sjsh3wWo6GyC8KlsMejMvV9iNlMpUx9m1
         e/eijDs1mEJFLO2TJBkN14g3t0J7/HRjYHt6jGqkdngI9wph52Q3ogRxNMdKAtzxeg25
         XcWL+ONayv2a0pAGg3swXgiokEXA9gilyRGOhIKTk6x9SVYmEuPxsePgRyIfDvwxlOgo
         +P+p48B+fjlmlUQjs4uiEbdAC7avrSnparZrobMq0G7U0aWx0KuTlGpL6KaJ4cD3tzP0
         zoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440527; x=1692045327;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=fvj0QdifwQ5vvoKDQWEVtzRri1tVtG2+KUZWJqFJDGRTd4ZZ4GvhrufzED20vjXXF2
         WcNGqpdJ+tSedLxDzuW8d4Uak/RfudCp8Z1AqGU4rwl2PkJGjtC3Kn2FjxW/Vk4CL5cg
         fCSp8rJCp3DC7O71DLsP6FaYilK6UU9qvPLEyO/28ueD2tzmTUck+f6viO8GBoz2bw7h
         vwX1trJ5d3CIf5nKryH2aDC90Mu8bje7qFnq7BEblG9DTwd6im3qk48ruKP+NMaVs13d
         MO/iISVhY3V4KWnZjGOZny2ZhUs2vbXdpyOY0+oFPl/5RClzfdAg/Zzoj3j4N2CHWk1C
         dvMg==
X-Gm-Message-State: AOJu0YxZ1Njhq+bLtJc1TmX/1H1WBtyFmSnBASxdjX3OtNJxiWOAkEK4
        0oD48YniLGVCR0Dxq1dzh9/WOLdySfQFjLwCWnE=
X-Google-Smtp-Source: AGHT+IH6RhdoplRqECcY8mUnEMQB3kKUONmBVdu9pLDcOmWR/5QFK305l7kYojCsuoKgbwfz4sV69GprXYw/1zMEwFI=
X-Received: by 2002:a0d:dfd8:0:b0:56c:e706:2e04 with SMTP id
 i207-20020a0ddfd8000000b0056ce7062e04mr12209481ywe.0.1691440527025; Mon, 07
 Aug 2023 13:35:27 -0700 (PDT)
MIME-Version: 1.0
Sender: lw466553@gmail.com
Received: by 2002:a05:7108:160f:b0:326:a9e:5940 with HTTP; Mon, 7 Aug 2023
 13:35:26 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Mon, 7 Aug 2023 13:35:26 -0700
X-Google-Sender-Auth: 0G1lXpJv-q7nK9NDmCu4G39nQek
Message-ID: <CAPHeqezXrZjPmETqsqybz9ND0xuLHy7Yn1jh0fx-tfjmjnpqCg@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
