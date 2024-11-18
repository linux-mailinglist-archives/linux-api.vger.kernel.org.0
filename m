Return-Path: <linux-api+bounces-2739-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589D9D1B2A
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2024 23:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A4B21F9F
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2024 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033961E7C1A;
	Mon, 18 Nov 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAkRxQGZ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA7158DAC
	for <linux-api@vger.kernel.org>; Mon, 18 Nov 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969527; cv=none; b=i9zQ/NNXFOpLznxlK+1vG6gmTJhNVh3/vnryCPY1UGnu+oKI/bzt4eR+Cejw/xgg9hUjbIYYitJaBiL12+Ew4Wq/JUOtiSPaZe75aztlQeaG2u0QfyOvE8V8fTNulEyQJ9TFv/2fEOSmLemCsQG9UBdhbzagyt04IxF/94F6cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969527; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=bblu+FgbLY9QbGCA6K7vBop9o0yXgtMy0wJpW+zpVnFL5RJgSY/mb4BgkWaM65tKP1oQ7trEcQOA+3nK22dKGYCZQxkwhEajFkV1nAN9cVNhpKj5dA2uhMSuehXzypjSNccBgpXQ/zTuSRlNv0/JD7txxfRuYX5+tynHTaocgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAkRxQGZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4319399a411so2025785e9.2
        for <linux-api@vger.kernel.org>; Mon, 18 Nov 2024 14:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731969524; x=1732574324; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=GAkRxQGZScVicIG2NeWsrkoO+gj1C9UTC1C3D4tWfW9Z2LEc/CkIJL/eBhCX/Zqne7
         WY46ttUG+23DG2LTfIww6/wYEXiZbMGuIWMnAIf+kf3LyHVla41rpCefKwRftyyE4M1N
         QAkg69ICnybyxbB01+CwgluJrif0yOzO+qcyPq7xcoT5dtdNs1R5ggF0BgaxcH5Pd9Wv
         yNqRWtG0YrvScraVokYj2zeM+MpjQDTdHfMwUT3R88qw6H1TTp9CMK+2ZgP4WWn2tC1C
         ycPy8iaplJzfm6YGVUABMtpgkszftI7aDe+bLhbGFFg1Xd45p4GN5P3gWoXX/F3uXduF
         v1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731969524; x=1732574324;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=KGyyFMOCbhcjCu0nxwzQrMBCFJ34N1s7inFDsOkCk+6RuDkVZDqeOt7I6eajOwcfok
         XS5toGnVwvqD14q4+btY1jKcZWy/Lv0zXuWAIbJtEAx0a+P6asZX0Hz3lBa4rheZy7rb
         HGsEaJETJ3PQQD+AwQKeYPpJAFbLFrAvyQ35w92FiExTCTnK11eNLLTNbtpHBlCMtO4R
         dSCkQbBEaixLXmZCqhrLvkIV0zh1ZY6oOgLNZlXepsmD168+qddZlK4gA5A77P6H6Hc6
         vwvVEHtN5w/pp722FVJCYRESLnyw55cP3FG31wVM1goD7SNIxhHEotluaN1+TLIKnqh0
         qXdg==
X-Gm-Message-State: AOJu0YxWjvNrvRoS8ErNPDT+bmVCiG8zBsbazgo4WzS4aM6Gu/N0ErKu
	/py6rvpeuR5b8/vbxgGLWPvumBpw7Lula6QRdljXsr1+ZJqgDIqBNUQQsg==
X-Google-Smtp-Source: AGHT+IFQ0CKP76R/6yVBrZf1JKdO8wt/oOmOOjJBh/FCL7AW1oIi7YhnS6yXRDY2Iiby4wD7LfJ1Tw==
X-Received: by 2002:a05:600c:46d0:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-432df74c6bcmr118364265e9.19.1731969524281;
        Mon, 18 Nov 2024 14:38:44 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38242eef982sm5929921f8f.8.2024.11.18.14.38.42
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2024 14:38:42 -0800 (PST)
From: William Cheung <nahydm98@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <ffa2d4231136a334f65bc266b5ab051e97527c9511086746b84a6602c706bb9e@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-api@vger.kernel.org
Subject: A Proposal
Date: Mon, 18 Nov 2024 14:38:31 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.

